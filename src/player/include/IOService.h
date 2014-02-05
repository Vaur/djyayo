/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2013 Jerome Quere <contact@jeromequere.com>
 *
 * Permission is hereby granted, free  of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction,  including without limitation the rights
 * to use,  copy,  modify,  merge, publish,  distribute, sublicense, and/or sell
 * copies  of  the  Software,  and  to  permit  persons  to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The  above  copyright  notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED  "AS IS",  WITHOUT WARRANTY  OF ANY KIND, EXPRESS OR
 * IMPLIED,  INCLUDING BUT NOT LIMITED  TO THE  WARRANTIES  OF  MERCHANTABILITY,
 * FITNESS  FOR A  PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS  OR  COPYRIGHT  HOLDERS  BE  LIABLE  FOR  ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT  OF  OR  IN  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#ifndef _SPDJ_IOSERVICE_H_
#define _SPDJ_IOSERVICE_H_

#include <functional>
#include <memory>

#include <QCoreApplication>
#include <QObject>

class QTimer;

namespace SpDj
{
    class IOService : public QObject
    {
	Q_OBJECT;

    public:

	class Event {
	public:
	    Event();
	    explicit Event(QTimer* timer);
	    void cancel();
	private:
	    QTimer* _timer;

	};

	IOService();
	~IOService();

	static int run();
	static void stop();
	static Event addTimer(long long millisecond, const std::function<void ()>&f);

	static void addTask(const std::function<void ()>&f);
	static void addTaskFromThread(const std::function<void ()>&f);

    Q_SIGNALS:
	void _addTask(std::function<void ()>* f);

    private Q_SLOTS:
	void _onAddTask(std::function<void ()>*f);

    private:
	void _onTimeout();
	void _removeTimer(QObject*);

	int			_argc;
	char**			_argv;
	QCoreApplication	_app;

	std::map<QObject*, std::function<void ()> > _cbs;

	friend class Event;
    };
}

#endif
