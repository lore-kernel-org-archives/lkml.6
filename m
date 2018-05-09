Return-Path: <ebiederm@xmission.com>
X-Google-Smtp-Source: AB8JxZp4SgaIU04xCFCMYtrGpczDZ10q/Tt8ziQQG4Dju2LLZIWy2be6q0DMLIoUQBfPcBcN4uBM
ARC-Seal: i=1; a=rsa-sha256; t=1525829013; cv=none;
        d=google.com; s=arc-20160816;
        b=hYdxJrF8x/vratrLntZShGfag95nits4rqgqGTbtfSqNe2/Xm/ROzyzKB09/h66Wgx
         ZvyWzzy5v6Cp3cH4sTn3CyKBL0s20wwqvdmyZcYLlazjAVJRaX5z2xap9IH7I6WPk5Nz
         prrRazws4ingarYox+pHwaLy9OpVsRm/2lFhBi/wjkjaMhL5cLSrEDBW93mp2iIsArGl
         LfWNWKQLIqTUJPMpgJBfsNxnKZpPWV/d7e19w1677fIy0bRYQd+j/UHns235e2WcH4LC
         Mc04P5NbRIHZp7qY3Hycx1dQL0meCXrSvdc/aR4d362MkBhNbYqjTDMD+6rolChJSBce
         RCSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:mime-version:user-agent:message-id:in-reply-to:date
         :references:cc:to:from:arc-authentication-results;
        bh=ZGlS8naLxfw2a+81X4ZzFgMQRfJ6EBZEVlo2TpSvBaY=;
        b=zWZYsP9IHMz8JweKUl/KSLBo2Fnc5lxsqt9FKc+qusBm7b8N88ndniAI0XneRoIpDH
         FUbNxodCJCTrWjxgkm8UGFXA49qnMBpY4d3u+VWL1ME4YvGfCN9aOPuwEqZ8ohd3pPWV
         Z9fL7TofZv9E5gR+RY0/Q9hsitrb5x1NW0K39QB2MK8M1KaliPK31q1usaSLyvdOxBHe
         zzwIUngcyZxMG2bWjeuDjXfWxsU4RGGd9vDWuLCy0uYZ2qNguP9wuWHepthJMD9x14rX
         XfY75aCT8WNx/jA9g1YTnGtIeNNuPL/IMjdlH+tk2x9JIowm2xEi8QzOkIrqmsoCGOsJ
         wQUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.233 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.233 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
From: ebiederm@xmission.com (Eric W. Biederman)
To: Kim Phillips <kim.phillips@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,  Alexander Shishkin <alexander.shishkin@linux.intel.com>,  Alex Williamson <alex.williamson@redhat.com>,  Andrew Morton <akpm@linux-foundation.org>,  David Howells <dhowells@redhat.com>,  Eric Auger <eric.auger@redhat.com>,  Gargi Sharma <gs051095@gmail.com>,  Geert Uytterhoeven <geert+renesas@glider.be>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  Kefeng Wang <wangkefeng.wang@huawei.com>,  Kirill Tkhai <ktkhai@virtuozzo.com>,  Mike Rapoport <rppt@linux.vnet.ibm.com>,  Oleg Nesterov <oleg@redhat.com>,  Pavel Tatashin <pasha.tatashin@oracle.com>,  Rik van Riel <riel@redhat.com>,  Robin Murphy <robin.murphy@arm.com>,  Russell King <linux@armlinux.org.uk>,  Thierry Reding <treding@nvidia.com>,  Todd Kjos <tkjos@google.com>,  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org
References: <20180508140640.0e312dba025df75cbf205cdb@arm.com>
Date: Tue, 08 May 2018 20:23:19 -0500
In-Reply-To: <20180508140640.0e312dba025df75cbf205cdb@arm.com> (Kim Phillips's
	message of "Tue, 8 May 2018 14:06:40 -0500")
Message-ID: <87k1sdvczc.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fGDpH-0003Sv-I1;;;mid=<87k1sdvczc.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.90.247.198;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Cw/2pdoVdnRzGR6QjzovQLkAutUEI54E=
X-SA-Exim-Connect-IP: 97.90.247.198
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.7 XMSubLong Long Subject
	*  0.5 XMGappySubj_01 Very gappy subject
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kim Phillips <kim.phillips@arm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1235 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 4.8 (0.4%), b_tie_ro: 3.3 (0.3%), parse: 1.15 (0.1%),
	extract_message_metadata: 28 (2.3%), get_uri_detail_list: 4.1 (0.3%),
	tests_pri_-1000: 13 (1.0%), tests_pri_-950: 1.11 (0.1%), tests_pri_-900: 0.94
	(0.1%), tests_pri_-400: 30 (2.4%), check_bayes: 29 (2.4%), b_tokenize: 9
	(0.7%), b_tok_get_all: 10 (0.8%), b_comp_prob: 2.2 (0.2%), b_tok_touch_all: 5
	(0.4%), b_finish: 0.80 (0.1%), tests_pri_0: 1150 (93.1%),
	check_dkim_signature: 0.38 (0.0%), check_dkim_adsp: 3.2 (0.3%),
	tests_pri_500: 3.5 (0.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/4] pid: Export find_task_by_vpid for use in external modules
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599923977519130436?=
X-GMAIL-MSGID: =?utf-8?q?1599947683395555800?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Kim Phillips <kim.phillips@arm.com> writes:

> This patch is in the context of allowing the Coresight h/w
> trace driver suite to be loaded as modules.  Coresight uses
> find_task_by_vpid when running in direct capture mode (via sysfs)
> when getting/setting the context ID comparator to trigger on
> (/sys/bus/coresight/devices/<x>.etm/ctxid_pid).

Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

There is no way to implement a sysfs file that takes a pid correctly.
Don't do it.

Pids are tied to pid namespaces and sysfs deliberately does not do
anything remotely resembly a pid namespace.

Eric


> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Gargi Sharma <gs051095@gmail.com>
> Cc: Rik van Riel <riel@redhat.com>
> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> ---
> Current CoreSight callsite:
>
> https://lxr.missinglinkelectronics.com/linux/include/linux/coresight.h#L285
>
> A quick look didn't find anything, but if Coresight needs to do
> something differently, please comment.
>
>  kernel/pid.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 157fe4b19971..92b1b623f3e0 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -342,6 +342,7 @@ struct task_struct *find_task_by_vpid(pid_t vnr)
>  {
>  	return find_task_by_pid_ns(vnr, task_active_pid_ns(current));
>  }
> +EXPORT_SYMBOL_GPL(find_task_by_vpid);
>  
>  struct task_struct *find_get_task_by_vpid(pid_t nr)
>  {
