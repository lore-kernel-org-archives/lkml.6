Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965184AbeBMRVZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:21:25 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52479 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964849AbeBMRVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:21:24 -0500
X-Google-Smtp-Source: AH8x225FoSEUgyrfKt6QyVbUJBEk12JMXgTz3YRdi/18vvHkFJ5FF3WLAvK6LVpBO4+ixklwNSViTw==
Date: Tue, 13 Feb 2018 18:21:19 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] kprobes: improve error handling when
 arming/disarming kprobes
Message-ID: <20180213172119.yurad3j3wyhapt74@gmail.com>
References: <20180109235124.30886-1-jeyu@kernel.org>
 <20180119160607.5ed19168be13d27cf7f94531@kernel.org>
 <1e95213f-1b57-00a4-46a3-70e9a9013994@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e95213f-1b57-00a4-46a3-70e9a9013994@redhat.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Joe Lawrence <joe.lawrence@redhat.com> wrote:

> Was this patch ever picked up in the tip tree?  (Maybe I'm not looking
> in the right branch?)

Sorry, had a bit of a backlog: I picked up the two fixes/improvements now, and 
they will show up in tip:perf/urgent once they go through some local testing.

Thanks!

	Ingo
