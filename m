Return-Path: <ebiederm@xmission.com>
X-Google-Smtp-Source: AB8JxZpvNGoNTwrV5/60qB0YiC/TTYc3rfCAK1AHo/JH9mvXXQ2y+J6g2viMkF28NFCQhb8bFVTf
ARC-Seal: i=1; a=rsa-sha256; t=1524846443; cv=none;
        d=google.com; s=arc-20160816;
        b=0e/MyxzGIgHrbhrykD0Lpbql4RReampYzZku4g1gcl18i81SpLmxzW3ydEp0yuSqtR
         DwoEfrNHUwCulK1UbAr+Btj/iKbuFVbL7sYaryjy7rv9uPEA9c3m87luskxt+Dthe2y4
         kjVZ8xkFtuI+wM7JwAU6S82eaVqJwNF6oHceD22JirZ86S+jiOxf+zx9+7T1Lcu4qwtq
         i0jOJY0YG35K/uSnjhUyOGYgaCg7wOoKvkRyeOl6xlSBRgwY3ru9Ta8ZNJIUP8HOxyws
         IyO2vEAf6OWT/HOmbdNXq51rOnbIZz4ZVOWYT2orgqqyjnTLRXBYCVJ552ao8OIku9AP
         g8+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:mime-version:user-agent:message-id:in-reply-to:date
         :references:cc:to:from:arc-authentication-results;
        bh=bMxam518YSRuMCCnEXuDfyHNtLu0AQVGt97Y4lsQO/Y=;
        b=KOjwsvGJWufIXmEemMNOVJVbsSNgd0vL1iV549kQFFRFIp9wsIEQSHbalJjJSYzVZa
         W49npCzKDWoTpe8Y/oXNS4rV3tFkHIBD0KX/DlAW2V8/0zqehdMLKw7XWIJirZyiV8U+
         wVFhucN+3HblyRWyUBW0/bhNoV+STy8uQ+Yqfgso4PMhkY3YSiVxbRDGMogJeU4qWD5o
         AYE29+Sp4LIyqghepZtmMgJ0Bx1z7Kjjib5Nm0n3io0IfCLZEZ//8XkJX+lZMqvXbOmq
         wa7worKeZC/NOptOIh0VMpISPT5/QTBhHhQSzn/5OS+ehuSusYvX+DzlSy2b8lkg6Smu
         remw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.231 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.231 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christian Brauner <christian.brauner@ubuntu.com>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,  avagin@virtuozzo.com,  ktkhai@virtuozzo.com,  serge@hallyn.com,  gregkh@linuxfoundation.org
References: <20180427102306.8617-1-christian.brauner@ubuntu.com>
Date: Fri, 27 Apr 2018 11:27:02 -0500
In-Reply-To: <20180427102306.8617-1-christian.brauner@ubuntu.com> (Christian
	Brauner's message of "Fri, 27 Apr 2018 12:23:04 +0200")
Message-ID: <87zi1o7gyx.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fC6DC-0000b0-EA;;;mid=<87zi1o7gyx.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/K900DyUPQyvAZAmQOZlfQVKK9bzbPHc0=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4344]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.1 XMSolicitRefs_0 Weightloss drug
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christian Brauner <christian.brauner@ubuntu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15030 ms - load_scoreonly_sql: 0.06 (0.0%),
	signal_user_changed: 3.1 (0.0%), b_tie_ro: 2.2 (0.0%), parse: 0.79 (0.0%),
	extract_message_metadata: 16 (0.1%), get_uri_detail_list: 2.0 (0.0%),
	tests_pri_-1000: 3.1 (0.0%), tests_pri_-950: 1.16 (0.0%), tests_pri_-900:
	1.03 (0.0%), tests_pri_-400: 21 (0.1%), check_bayes: 20 (0.1%), b_tokenize: 7
	(0.0%), b_tok_get_all: 6 (0.0%), b_comp_prob: 2.1 (0.0%), b_tok_touch_all:
	2.9 (0.0%), b_finish: 0.72 (0.0%), tests_pri_0: 164 (1.1%),
	check_dkim_signature: 0.69 (0.0%), check_dkim_adsp: 2.9 (0.0%),
	tests_pri_500: 14817 (98.6%), poll_dns_idle: 14803 (98.5%), rewrite_mail:
	0.00 (0.0%)
Subject: Re: [PATCH net-next 0/2] netns: uevent filtering
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598894614112495880?=
X-GMAIL-MSGID: =?utf-8?q?1598917384204747700?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Christian Brauner <christian.brauner@ubuntu.com> writes:

> Hey everyone,
>
> This is the new approach to uevent filtering as discussed (see the
> threads in [1], [2], and [3]).
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

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Overall this change looks good and I would nave not problems
if it was merged as it.  I have one or two nits.  But they are not
particularly important.

Eric


> Thanks!
> Christian
>
> [1]: https://lkml.org/lkml/2018/4/4/739
> [2]: https://lkml.org/lkml/2018/4/26/767
> [3]: https://lkml.org/lkml/2018/4/26/738
>
> Christian Brauner (2):
>   uevent: add alloc_uevent_skb() helper
>   netns: restrict uevents
>
>  lib/kobject_uevent.c | 175 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 123 insertions(+), 52 deletions(-)
