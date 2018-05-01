Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752898AbeEADqO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 23:46:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47672 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751512AbeEADqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 23:46:13 -0400
Subject: Re: [PATCH RFC v5 4/6] trace/irqsoff: Split reset into seperate
 functions
To: Joel Fernandes <joelaf@google.com>, linux-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Fenguang Wu <fengguang.wu@intel.com>,
        Baohong Liu <baohong.liu@intel.com>,
        Vedang Patel <vedang.patel@intel.com>, kernel-team@android.com
References: <20180501014204.67548-1-joelaf@google.com>
 <20180501014204.67548-5-joelaf@google.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <31312b91-fd30-5b1c-6a8e-39ff2b58b5a8@infradead.org>
Date: Mon, 30 Apr 2018 20:45:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501014204.67548-5-joelaf@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/30/2018 06:42 PM, Joel Fernandes wrote:
> Split reset functions into seperate functions in preparation
> of future patches that need to do tracer specific reset.
> 

Hi,
Since you are updating patches anyway, please
s/seperate/separate/.

thanks,
-- 
~Randy
