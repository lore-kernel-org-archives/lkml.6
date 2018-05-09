Return-Path: <ebiederm@xmission.com>
X-Google-Smtp-Source: AB8JxZqKXglG3jCrLMj0ogo6u8o7fZyjTGvyIST/tWuEGgaHLgfiSHM5TsvCYhNCGnHFFSfNvCwI
ARC-Seal: i=1; a=rsa-sha256; t=1525841992; cv=none;
        d=google.com; s=arc-20160816;
        b=oEOVKbjh26+R05OlrEhG4nJBmm6kilasEUiKj0eB/RLUd869repaWtb7MzZDijrmHb
         sOs4y76HMNGA78cGeUyQXh55/sS+Aa0/TTbmw0WR2AmT8waZ7psKd6cVR4WsIZ5TLGId
         uiss/0/qXbFdSYk9fWXjnoQYU9n5dM6yVeq50J1P0Lf7kqn9JayeJeypr0h//0iaRwW7
         0woqGnsNt7exWRwloLlhjhfs3AQjFTgzOt5JO5bPLBe24grVEr02YqYvd4R4Zy6x5wU9
         4w7FGy8LHa4btOwzBiW/t5MGUOIzijueqRtRVNECQka3ZkZk27Xw/WZCdYNLSqL0umHl
         TVeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:mime-version:user-agent:message-id:in-reply-to:date
         :references:cc:to:from:arc-authentication-results;
        bh=U/eAeNg8cI5AoNA+drIJF9O+IkKieYBpAgXUeN1Hk7s=;
        b=jmKTg56y/4SOatK7UIkLoIS/0D05PX/KcXm7CmEdXIBFzZsZY70TdQGjywhVYDIJdn
         U4gpGNjGWbDcmzQpF448xu9JCLfz8t186dHa36gjZAuSXwVuTCfV4iA7P6iity4cIArZ
         b30qb9F6silj3tJJsLzA5WFs+mpbNXPO+gEfH6JGlq8B9hRtxzvTJxUmBL40v2XWh12H
         UjXBpRt5al6P9OGmu3qjZyejqkykTzsIp3lmRq2FPEmomOIJzxTfMAwmcNbEWPmXpgDN
         bRm7EPcskHlwpA4wo+FlNaKVxJiiaq/wPfyPfXytQ93JAhHwLWu2TExL6TMDPp7lB+k4
         CCog==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.233 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.233 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
From: ebiederm@xmission.com (Eric W. Biederman)
To: Kim Phillips <kim.phillips@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,  Alexander Shishkin <alexander.shishkin@linux.intel.com>,  Alex Williamson <alex.williamson@redhat.com>,  Andrew Morton <akpm@linux-foundation.org>,  David Howells <dhowells@redhat.com>,  Eric Auger <eric.auger@redhat.com>,  Gargi Sharma <gs051095@gmail.com>,  Geert Uytterhoeven <geert+renesas@glider.be>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  Kefeng Wang <wangkefeng.wang@huawei.com>,  Kirill Tkhai <ktkhai@virtuozzo.com>,  Mike Rapoport <rppt@linux.vnet.ibm.com>,  Oleg Nesterov <oleg@redhat.com>,  Pavel Tatashin <pasha.tatashin@oracle.com>,  Rik van Riel <riel@redhat.com>,  Robin Murphy <robin.murphy@arm.com>,  Russell King <linux@armlinux.org.uk>,  Thierry Reding <treding@nvidia.com>,  Todd Kjos <tkjos@google.com>,  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org
References: <20180508140640.0e312dba025df75cbf205cdb@arm.com>
Date: Tue, 08 May 2018 23:59:38 -0500
In-Reply-To: <20180508140640.0e312dba025df75cbf205cdb@arm.com> (Kim Phillips's
	message of "Tue, 8 May 2018 14:06:40 -0500")
Message-ID: <87d0y5toed.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fGHCd-0002WG-2k;;;mid=<87d0y5toed.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.90.247.198;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18du64CmzAz3xD14+kQxRF1fN5SnunMfRY=
X-SA-Exim-Connect-IP: 97.90.247.198
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.7 XMSubLong Long Subject
	*  0.5 XMGappySubj_01 Very gappy subject
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4995]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kim Phillips <kim.phillips@arm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1421 ms - load_scoreonly_sql: 0.06 (0.0%),
	signal_user_changed: 3.0 (0.2%), b_tie_ro: 2.1 (0.1%), parse: 1.16 (0.1%),
	extract_message_metadata: 24 (1.7%), get_uri_detail_list: 1.63 (0.1%),
	tests_pri_-1000: 11 (0.8%), tests_pri_-950: 2.3 (0.2%), tests_pri_-900: 1.89
	(0.1%), tests_pri_-400: 33 (2.3%), check_bayes: 30 (2.1%), b_tokenize: 13
	(0.9%), b_tok_get_all: 7 (0.5%), b_comp_prob: 4.1 (0.3%), b_tok_touch_all:
	3.1 (0.2%), b_finish: 0.85 (0.1%), tests_pri_0: 1331 (93.7%),
	check_dkim_signature: 0.89 (0.1%), check_dkim_adsp: 4.6 (0.3%),
	tests_pri_500: 8 (0.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/4] pid: Export find_task_by_vpid for use in external modules
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599923977519130436?=
X-GMAIL-MSGID: =?utf-8?q?1599961293767270055?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Kim Phillips <kim.phillips@arm.com> writes:

> This patch is in the context of allowing the Coresight h/w
> trace driver suite to be loaded as modules.  Coresight uses
> find_task_by_vpid when running in direct capture mode (via sysfs)
> when getting/setting the context ID comparator to trigger on
> (/sys/bus/coresight/devices/<x>.etm/ctxid_pid).

Aside from my objection about how bad an interface a pid in sysfs is.
The implementation of coresight_vpid_to_pid is horrible.

The code should be just:

static inline pid_t coresight_vpid_to_pid(pid_t vpid)
{
	rcu_read_lock();
        pid = pid_nr(find_vpid(vpid));
	rcu_read_unlock();

	return pid;
}
Which takes find_task_by_vpid out of the picture.

But reading further I am seeing code writing a pid to hardware.  That is
broken.  That is a layering violation of the first order.  Giving
implementation details like that to hardware.

Any chance while you are working on this you can modify this code so
that it does something sensible and defensible instead of every line of
code I read be wrong in at least one detail?

Thank you,
Eric
