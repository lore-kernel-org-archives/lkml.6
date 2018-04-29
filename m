Return-Path: <ebiederm@xmission.com>
X-Google-Smtp-Source: AB8JxZqdCWqgWLRIILb2jb+bs1q69mB/dnTElgbegr4TPf/TU4QOhc1k9ie+VZNpTWQi0bqCy2le
ARC-Seal: i=1; a=rsa-sha256; t=1524975908; cv=none;
        d=google.com; s=arc-20160816;
        b=u1Ip2WBkB0O5+apQUzA3C6ffAn52PWX17lkvzAUR+xSAF5vC1rBAF2CEOyd/4ze+gG
         AnDwwyMIqhUhZJljjHbO6LKjILNhYzSlBk1b5ECR/sjIj5hk16TmCFraH83dKGhlxVzD
         rdFzMUifW7L0xh7jqomxgPuxpNEUjYl3GaH1FMdz/ATO03uTTLXkgRMZKD1eUqgrScSq
         Udla/ez/kECqr1oKq/4VMjvXsyIYbHLoCE77D5YhiWGfg2rvR6jeO1d7yiIcHGzRswg5
         Brzrc9kGOjxjoYHuAf5O3GhjhmLEvgxk6dbfRHvewHC7XKSBDfY0EbE83SKXsxkn0n3f
         dfyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:mime-version:user-agent:message-id:in-reply-to:date
         :references:cc:to:from:arc-authentication-results;
        bh=xEPXDdxpVpBpSoiMlLUzjZChlsY6dI0K7qisxFjJIN8=;
        b=szFx5/QQbyO1lw71rs+nC/pYTu84XiWCBGlJ3as2JFwt4Ab/tETf5F2cQQLAixJK7L
         ImKMWu/1xFj0yPqGI+/4FVwKP582E5FGoDSUDTvierEssGK3O2ndRRjmhp15OrvMmvaH
         Su9wVBT0UFqyY1KkSzz4G+iOWnshYHKJcKDuMkkQxchqs4pAAP949PIcr7KorNWhVs1K
         w8vfYCOZaNrWdpTu+YG4NPc8FPF0+sp56uJrpUqBwcO3nTD5+wLeJIey33Yr/BBqfwYK
         JlexuzY/UH0HP9eMR8F6NEgvjnNLGFMEcPE9KDArzsAU2XnUwf57rqWFo3cu2cTAIXwy
         +YCg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.231 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.231 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christian Brauner <christian.brauner@ubuntu.com>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,  avagin@virtuozzo.com,  ktkhai@virtuozzo.com,  serge@hallyn.com,  gregkh@linuxfoundation.org
References: <20180428192025.2075-1-christian.brauner@ubuntu.com>
Date: Sat, 28 Apr 2018 23:25:01 -0500
In-Reply-To: <20180428192025.2075-1-christian.brauner@ubuntu.com> (Christian
	Brauner's message of "Sat, 28 Apr 2018 21:20:23 +0200")
Message-ID: <87d0yid4gy.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fCdta-00065o-AL;;;mid=<87d0yid4gy.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.116.237.29;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX198nxDMqE3cEnMYMU3HGDcs7UKQbAXDydQ=
X-SA-Exim-Connect-IP: 68.116.237.29
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4928]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.1 XMSolicitRefs_0 Weightloss drug
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christian Brauner <christian.brauner@ubuntu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 219 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 2.8 (1.3%), b_tie_ro: 1.95 (0.9%), parse: 0.96 (0.4%),
	extract_message_metadata: 18 (8.1%), get_uri_detail_list: 2.8 (1.3%),
	tests_pri_-1000: 9 (4.2%), tests_pri_-950: 1.15 (0.5%), tests_pri_-900: 0.98
	(0.4%), tests_pri_-400: 20 (8.9%), check_bayes: 19 (8.5%), b_tokenize: 6
	(2.9%), b_tok_get_all: 6 (2.6%), b_comp_prob: 1.92 (0.9%), b_tok_touch_all:
	2.6 (1.2%), b_finish: 0.63 (0.3%), tests_pri_0: 160 (72.8%),
	check_dkim_signature: 0.45 (0.2%), check_dkim_adsp: 2.4 (1.1%),
	tests_pri_500: 4.7 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH net-next 0/2 v4] netns: uevent filtering
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599018881448203807?=
X-GMAIL-MSGID: =?utf-8?q?1599053137694610129?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Christian Brauner <christian.brauner@ubuntu.com> writes:

> Hey everyone,
>
> This is the new approach to uevent filtering as discussed (see the
> threads in [1], [2], and [3]). It only contains *non-functional
> changes*.
>
> This series deals with with fixing up uevent filtering logic:
> - uevent filtering logic is simplified
> - locking time on uevent_sock_list is minimized
> - tagged and untagged kobjects are handled in separate codepaths
> - permissions for userspace are fixed for network device uevents in
>   network namespaces owned by non-initial user namespaces
>   Udev is now able to see those events correctly which it wasn't before.
>   For example, moving a physical device into a network namespace not
>   owned by the initial user namespaces before gave:
>
>   root@xen1:~# udevadm --debug monitor -k
>   calling: monitor
>   monitor will print the received events for:
>   KERNEL - the kernel uevent
>
>   sender uid=65534, message ignored
>   sender uid=65534, message ignored
>   sender uid=65534, message ignored
>   sender uid=65534, message ignored
>   sender uid=65534, message ignored
>
>   and now after the discussion and solution in [3] correctly gives:
>
>   root@xen1:~# udevadm --debug monitor -k
>   calling: monitor
>   monitor will print the received events for:
>   KERNEL - the kernel uevent
>
>   KERNEL[625.301042] add      /devices/pci0000:00/0000:00:02.0/0000:01:00.1/net/enp1s0f1 (net)
>   KERNEL[625.301109] move     /devices/pci0000:00/0000:00:02.0/0000:01:00.1/net/enp1s0f1 (net)
>   KERNEL[625.301138] move     /devices/pci0000:00/0000:00:02.0/0000:01:00.1/net/eth1 (net)
>   KERNEL[655.333272] remove /devices/pci0000:00/0000:00:02.0/0000:01:00.1/net/eth1 (net)
>
> Thanks!
> Christian
>
> [1]: https://lkml.org/lkml/2018/4/4/739
> [2]: https://lkml.org/lkml/2018/4/26/767
> [3]: https://lkml.org/lkml/2018/4/26/738

Again ovearall ack.  One last nit that might be worth addressing.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Eric
