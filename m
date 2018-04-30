Return-Path: <ebiederm@xmission.com>
X-Google-Smtp-Source: AB8JxZr37qemRmmGkJGI/FsjRhZSh0B+8w3Sy1cfK0aOy5CMPSQ7H0ibtxgkSvbWnU4igAuS8YyZ
ARC-Seal: i=1; a=rsa-sha256; t=1525103777; cv=none;
        d=google.com; s=arc-20160816;
        b=CrtiiMBN+gCazNqMBdWY/Y1n9WkXINuULsyWzAXotBPteRYnAAEtgyv8BusyRX6HYg
         Tc/pyPdXMAKHT/ScM0N0WPah6npLYv21MsGBIDWCsOu3D0EmurWZe8nFdtMvDJdTHOVo
         N6yCS0G4qiklrvLv93Z73zFGlYFMfOE7sCXY6uCXUVNPDDuKZ9GQL/OqPAL2dxHgShYk
         XwES78Dy4UyaSxMqyN7VpEGfKHDFc49qQf9eshF3ouiAb+rWFuf6GJbWShdKha/O0VwI
         gSXqDmc1PQNT4Lr826D4iR/aJcTyE3QLlDyBm2zeOUGdDKBHWlDiN3PtcBXkwxzUz34i
         znIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:mime-version:user-agent:message-id:in-reply-to:date
         :references:cc:to:from:arc-authentication-results;
        bh=19b4SvwfPYgohKmYh1/InBRNHrhNiW7l89EnDSMPXU8=;
        b=wBnfI9yF3KiBraXep9AVgL0shJhlq1IgBMgFV0zEWsi1SXvAY3iBoLG8nO318L4yD5
         UNAXREAbnB+DAAm8HhmWmpPgTP5L9CluyMUZK8XF/EZFHghqV/lMEuZPlFJKNAqWds6I
         I0CgKOpvy2h3nKHbBR63QXtQD2UmaOf/jIHYnCXWMhiDdnhkD0VkQZ/UZqmA2ZSFPt+9
         GKKCQuchk/HmiE4SEcmOxGeVsrkZo4UcnzqfPT45UM+cLxbQmevWT/287b58PPaBKblr
         jQob40exdyAovRLjAQAKhn+sp72RYpuQ8JYizG6rtAqoG1KfxiYT8KFCq0/P+52WyZvX
         Pqhg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.232 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.232 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christian Brauner <christian.brauner@ubuntu.com>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,  avagin@virtuozzo.com,  ktkhai@virtuozzo.com,  serge@hallyn.com,  gregkh@linuxfoundation.org
References: <20180429104412.22445-1-christian.brauner@ubuntu.com>
Date: Mon, 30 Apr 2018 10:55:55 -0500
In-Reply-To: <20180429104412.22445-1-christian.brauner@ubuntu.com> (Christian
	Brauner's message of "Sun, 29 Apr 2018 12:44:10 +0200")
Message-ID: <87fu3cbsdw.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fDB9k-0001RM-BY;;;mid=<87fu3cbsdw.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19VcS1Rh26zKMPlNfhAVavSCYK/i7rglDU=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4601]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.1 XMSolicitRefs_0 Weightloss drug
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christian Brauner <christian.brauner@ubuntu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15028 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 2.8 (0.0%), b_tie_ro: 1.87 (0.0%), parse: 0.73 (0.0%),
	extract_message_metadata: 15 (0.1%), get_uri_detail_list: 1.96 (0.0%),
	tests_pri_-1000: 2.9 (0.0%), tests_pri_-950: 1.15 (0.0%), tests_pri_-900:
	1.03 (0.0%), tests_pri_-400: 21 (0.1%), check_bayes: 20 (0.1%), b_tokenize: 7
	(0.0%), b_tok_get_all: 6 (0.0%), b_comp_prob: 1.95 (0.0%), b_tok_touch_all:
	2.8 (0.0%), b_finish: 0.72 (0.0%), tests_pri_0: 185 (1.2%),
	check_dkim_signature: 0.48 (0.0%), check_dkim_adsp: 8 (0.1%), tests_pri_500:
	14795 (98.5%), poll_dns_idle: 14784 (98.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH net-next 0/2 v5] netns: uevent filtering
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599077004828533491?=
X-GMAIL-MSGID: =?utf-8?q?1599187218462888223?=
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

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

>
> Christian Brauner (2):
>   uevent: add alloc_uevent_skb() helper
>   netns: restrict uevents
>
>  lib/kobject_uevent.c | 178 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 126 insertions(+), 52 deletions(-)

Eric
