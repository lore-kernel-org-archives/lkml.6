Return-Path: <ebiederm@xmission.com>
X-Google-Smtp-Source: AB8JxZpEIbO+Cu9plltMGZmV7faDpVcJCRFTk0k07BYkb+VJp0PD0e6sDCfYBJc6Sa2UugCS1ubx
ARC-Seal: i=1; a=rsa-sha256; t=1526535588; cv=none;
        d=google.com; s=arc-20160816;
        b=eEzh+RqghNNl6XQ6fh49dwxGpaoMWwTEGBAEzUXfLQai/3bNI0cfcXlJlKIaOIMqpT
         m4VBeQagwCratlNGY4P0G+dMs9pbdrWDM3jd7xpIApYZVycQ14D7TZed/mD83UhYbf3B
         1nCuyU1AVXrdD7YoMyRehQXY/oB7CIi5zCABB5NL4f3bjrIWQca61OqzC1gSy4FdgG38
         3CQ7Yw4ojMfvFm0k4vIT4r/VAOnOI+xwGifDMCCQkwR0ouUT2U8meM53hINsvGkT10Rp
         PVIs3L3B9M2vI+HIjgyHj+yOTsSPpy8vqm0uYeNGCMtYcIKtXyAR0gWxuz0s2iqARSks
         fu2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:mime-version:user-agent:message-id:in-reply-to:date
         :references:cc:to:from:arc-authentication-results;
        bh=1sIoPmuRy6aK7offSX5VcEixv/vn5ebBpCYqxJaYyMA=;
        b=ijMvZ0YJrc6kljy1vZCVVJMMELbSUYADcQEi3j/s5hVZSBriwt/OxneOV9RpzQem4U
         tP6scge0F+f4MOgj/LNGXL6zMLWw6KwYzwk4Jr1+yDNsXwNvBBarXGsLLvtt7aZQFTr8
         XJf64a11KoP9A7pJlPVjGrktn2ErwoaZT7OghbiMRCv8CDeS9KCiYOX3JCwDk4H94XGs
         n+gWLNyRlrpyfDEcJC6SCPfF/Ja6E8gL2LFxjXVbQ0sLuOpYZhQrXSsiPdrQ54H3exaO
         9FAHxfryFs8q8o66Z7oi9eEr9JN110My7X3AX4qz2mKDZKw/RKfFpoYyW9StM7wmYWxK
         k/IA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.231 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.231 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
From: ebiederm@xmission.com (Eric W. Biederman)
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,  Kim Phillips <kim.phillips@arm.com>,  Alexander Shishkin <alexander.shishkin@linux.intel.com>,  Alex Williamson <alex.williamson@redhat.com>,  Andrew Morton <akpm@linux-foundation.org>,  David Howells <dhowells@redhat.com>,  Eric Auger <eric.auger@redhat.com>,  Gargi Sharma <gs051095@gmail.com>,  Geert Uytterhoeven <geert+renesas@glider.be>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  Kefeng Wang <wangkefeng.wang@huawei.com>,  Kirill Tkhai <ktkhai@virtuozzo.com>,  Mike Rapoport <rppt@linux.vnet.ibm.com>,  Oleg Nesterov <oleg@redhat.com>,  Pavel Tatashin <pasha.tatashin@oracle.com>,  Rik van Riel <riel@redhat.com>,  Robin Murphy <robin.murphy@arm.com>,  Thierry Reding <treding@nvidia.com>,  Todd Kjos <tkjos@google.com>,  linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,  linux-kernel@vger.kernel.org
References: <20180508140640.0e312dba025df75cbf205cdb@arm.com>
	<87d0y5toed.fsf@xmission.com> <20180509152505.GA25559@xps15>
	<87k1scs0f8.fsf@xmission.com>
	<20180510084057.GT16141@n2100.armlinux.org.uk>
	<CANLsYkwaNmZCUjwJXK0X1ia+RnzumfbpB8EvZJ-HDtOHj8rafQ@mail.gmail.com>
	<20180510194422.GX16141@n2100.armlinux.org.uk>
Date: Thu, 17 May 2018 00:39:37 -0500
In-Reply-To: <20180510194422.GX16141@n2100.armlinux.org.uk> (Russell King's
	message of "Thu, 10 May 2018 20:44:22 +0100")
Message-ID: <87k1s2j0x2.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fJBdf-0004lw-QH;;;mid=<87k1s2j0x2.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.90.247.198;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18imAWKBCkq3kVz8yIHNpLev3T+O5HQgSI=
X-SA-Exim-Connect-IP: 97.90.247.198
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.5 XMGappySubj_01 Very gappy subject
	*  0.7 XMSubLong Long Subject
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4992]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Russell King - ARM Linux <linux@armlinux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1060 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 3.3 (0.3%), b_tie_ro: 2.2 (0.2%), parse: 1.01 (0.1%),
	extract_message_metadata: 11 (1.0%), get_uri_detail_list: 1.41 (0.1%),
	tests_pri_-1000: 6 (0.6%), tests_pri_-950: 1.15 (0.1%), tests_pri_-900: 0.99
	(0.1%), tests_pri_-400: 22 (2.1%), check_bayes: 21 (2.0%), b_tokenize: 7
	(0.7%), b_tok_get_all: 7 (0.6%), b_comp_prob: 2.0 (0.2%), b_tok_touch_all:
	3.6 (0.3%), b_finish: 0.64 (0.1%), tests_pri_0: 142 (13.4%),
	check_dkim_signature: 0.46 (0.0%), check_dkim_adsp: 2.5 (0.2%),
	tests_pri_500: 869 (82.0%), poll_dns_idle: 864 (81.5%), rewrite_mail: 0.00
	(0.0%)
Subject: Re: [PATCH 2/4] pid: Export find_task_by_vpid for use in external modules
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599923977519130436?=
X-GMAIL-MSGID: =?utf-8?q?1600688581622839426?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Russell King - ARM Linux <linux@armlinux.org.uk> writes:

> On Thu, May 10, 2018 at 01:39:18PM -0600, Mathieu Poirier wrote:
>> Hi Russell,
>> 
>> On 10 May 2018 at 02:40, Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
>> > This does not leak information from other namespaces because of the
>> > uniqueness of the global PID.  However, what it does leak is the value
>> > of the global PID which is meaningless in the namespace.  So, before
>> > the event stream is delivered to userspace, this value needs to be
>> > re-written to the namespace's PID value.
>> 
>> Unfortunately that can't be done.  The trace stream is compressed and
>> needs to be decompressed using an external library.  I think the only
>> option is to return an error if a user is trying to use this feature
>> from a namespace.
>
> That sounds like a sensible approach, and that should get rid of the
> vpid stuff too.
>
> Eric, would this solve all your concerns?

It does, and I have given my ack to the respin.

I am moderately concerned about using the global pid with hardware.  But
pids are a core abstraction that aren't going anywhere.  As long as
hardware does not impose constraints on pids that software already does
not we should be fine.

Eric
