Return-Path: <ebiederm@xmission.com>
X-Google-Smtp-Source: AIpwx49GOrwX7z4oT63KN75HfrgOniauNJBG+Bg7SEq3GO62Myv7Ssaekw/m9JyW7KrGRlUIbdBI
ARC-Seal: i=1; a=rsa-sha256; t=1524609696; cv=none;
        d=google.com; s=arc-20160816;
        b=WdkKwyEH0jFjyy3S22xUV7jDbHh5Te+Kum1VTtRbpg+05dppZj2tg3e/+6qm7yNdji
         +Rohx4LLZ8B9XFfvNjnu8RrPdBlcnhsZrRh0TC4I380pQCoZkUWWijYok3OErVmRTHiw
         0QJCh4bBO7z/7uD9lSrHSzphoK2+dk/ansQE/TRriWxBCzmtwuBtoRP6O28SxfY/nYih
         qz8yK+7R+qe2IOfRQigFRefNUKeBZwD4j2Q89AgxkYxktTNnHUOtbqj7g7MQ8aZQ2R0p
         LnO7m6S8bIZJWfPbE88mOk9BZkw1ZfBqKiqMpSeLMZmWR/K1O6HCN69nyT7rh1hJoBNP
         ADeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:mime-version:user-agent:message-id:in-reply-to:date
         :references:cc:to:from:arc-authentication-results;
        bh=n9JWCbhXwx9qfm9J7x6gCfH/MxoONgyx0Cm+Oj7h3O8=;
        b=w8mOgSq16z2vBP1xG3g8p1/W07Mc31WS3t2dem1LObmy5G/unWVUXkK+F6aE4r3VPl
         OrsbUcIucZOyaN6rb6amWmLPcrrRDZIQvmAb5J0504bzEx8Ok7pmKa43QosAAEBxTkxk
         8U/QhZi1hrqQunB/E2Twc70Iu/2+tpuyxJobLwwIMjbiG5IMMheL19VBh2wbW+e1eM9a
         8JwuCzWJBmHoygQ/ZMovZzq4YSEvgJGWTVUe24RV5ifGb1JJz6vu+HE1IkPnIqKQ8jDt
         rmFczThc+ABfCK8cnWrPmT4fmJqD5h0rn/uMdaeXib1QFg3g9gxtLR+NB6zeUG4cGcJI
         85xg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.232 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.232 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christian Brauner <christian.brauner@ubuntu.com>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,  avagin@virtuozzo.com,  ktkhai@virtuozzo.com,  serge@hallyn.com,  gregkh@linuxfoundation.org
References: <20180424204335.12904-1-christian.brauner@ubuntu.com>
	<20180424204335.12904-2-christian.brauner@ubuntu.com>
Date: Tue, 24 Apr 2018 17:40:07 -0500
In-Reply-To: <20180424204335.12904-2-christian.brauner@ubuntu.com> (Christian
	Brauner's message of "Tue, 24 Apr 2018 22:43:34 +0200")
Message-ID: <87po2oz0s8.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fB6cu-0004Xa-CN;;;mid=<87po2oz0s8.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX185XJa2ZDQgQNZcfwmvhKrozMLoPkOL/Js=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.2 T_XMDrugObfuBody_14 obfuscated drug references
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christian Brauner <christian.brauner@ubuntu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1168 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 3.8 (0.3%), b_tie_ro: 2.9 (0.2%), parse: 1.51 (0.1%),
	extract_message_metadata: 35 (3.0%), get_uri_detail_list: 7 (0.6%),
	tests_pri_-1000: 13 (1.1%), tests_pri_-950: 2.1 (0.2%), tests_pri_-900: 1.63
	(0.1%), tests_pri_-400: 54 (4.7%), check_bayes: 52 (4.5%), b_tokenize: 22
	(1.9%), b_tok_get_all: 12 (1.0%), b_comp_prob: 8 (0.7%), b_tok_touch_all: 3.7
	(0.3%), b_finish: 0.81 (0.1%), tests_pri_0: 1042 (89.3%),
	check_dkim_signature: 0.97 (0.1%), check_dkim_adsp: 4.3 (0.4%),
	tests_pri_500: 7 (0.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH net-next 1/2 v2] netns: restrict uevents
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598661751720131852?=
X-GMAIL-MSGID: =?utf-8?q?1598669137004919522?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Bah.  This code is obviously correct and probably wrong.

How do we deliver uevents for network devices that are outside of the
initial user namespace?  The kernel still needs to deliver those.

The logic to figure out which network namespace a device needs to be
delivered to is is present in kobj_bcast_filter.  That logic will almost
certainly need to be turned inside out.  Sign not as easy as I would
have hoped.

Eric

Christian Brauner <christian.brauner@ubuntu.com> writes:
> commit 07e98962fa77 ("kobject: Send hotplug events in all network namespaces")
>
> enabled sending hotplug events into all network namespaces back in 2010.
> Over time the set of uevents that get sent into all network namespaces has
> shrunk a little. We have now reached the point where hotplug events for all
> devices that carry a namespace tag are filtered according to that
> namespace. Specifically, they are filtered whenever the namespace tag of
> the kobject does not match the namespace tag of the netlink socket. One
> example are network devices. Uevents for network devices only show up in
> the network namespaces these devices are moved to or created in.
>
> However, any uevent for a kobject that does not have a namespace tag
> associated with it will not be filtered and we will broadcast it into all
> network namespaces. This behavior stopped making sense when user namespaces
> were introduced.
>
> This patch restricts uevents to the initial user namespace for a couple of
> reasons that have been extensively discusses on the mailing list [1].
> - Thundering herd:
>   Broadcasting uevents into all network namespaces introduces significant
>   overhead.
>   All processes that listen to uevents running in non-initial user
>   namespaces will end up responding to uevents that will be meaningless to
>   them. Mainly, because non-initial user namespaces cannot easily manage
>   devices unless they have a privileged host-process helping them out. This
>   means that there will be a thundering herd of activity when there
>   shouldn't be any.
> - Uevents from non-root users are already filtered in userspace:
>   Uevents are filtered by userspace in a user namespace because the
>   received uid != 0. Instead the uid associated with the event will be
>   65534 == "nobody" because the global root uid is not mapped.
>   This means we can safely and without introducing regressions modify the
>   kernel to not send uevents into all network namespaces whose owning user
>   namespace is not the initial user namespace because we know that
>   userspace will ignore the message because of the uid anyway. I have
>   a) verified that is is true for every udev implementation out there b)
>   that this behavior has been present in all udev implementations from the
>   very beginning.
> - Removing needless overhead/Increasing performance:
>   Currently, the uevent socket for each network namespace is added to the
>   global variable uevent_sock_list. The list itself needs to be protected
>   by a mutex. So everytime a uevent is generated the mutex is taken on the
>   list. The mutex is held *from the creation of the uevent (memory
>   allocation, string creation etc. until all uevent sockets have been
>   handled*. This is aggravated by the fact that for each uevent socket that
>   has listeners the mc_list must be walked as well which means we're
>   talking O(n^2) here. Given that a standard Linux workload usually has
>   quite a lot of network namespaces and - in the face of containers - a lot
>   of user namespaces this quickly becomes a performance problem (see
>   "Thundering herd" above). By just recording uevent sockets of network
>   namespaces that are owned by the initial user namespace we significantly
>   increase performance in this codepath.
> - Injecting uevents:
>   There's a valid argument that containers might be interested in receiving
>   device events especially if they are delegated to them by a privileged
>   userspace process. One prime example are SR-IOV enabled devices that are
>   explicitly designed to be handed of to other users such as VMs or
>   containers.
>   This use-case can now be correctly handled since
>   commit 692ec06d7c92 ("netns: send uevent messages"). This commit
>   introduced the ability to send uevents from userspace. As such we can let
>   a sufficiently privileged (CAP_SYS_ADMIN in the owning user namespace of
>   the network namespace of the netlink socket) userspace process make a
>   decision what uevents should be sent. This removes the need to blindly
>   broadcast uevents into all user namespaces and provides a performant and
>   safe solution to this problem.
> - Filtering logic:
>   This patch filters by *owning user namespace of the network namespace a
>   given task resides in* and not by user namespace of the task per se. This
>   means if the user namespace of a given task is unshared but the network
>   namespace is kept and is owned by the initial user namespace a listener
>   that is opening the uevent socket in that network namespace can still
>   listen to uevents.
>
> [1]: https://lkml.org/lkml/2018/4/4/739
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> Changelog v1->v2:
> * patch unchanged
> Changelog v0->v1:
> * patch unchanged
> ---
>  lib/kobject_uevent.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> index 15ea216a67ce..f5f5038787ac 100644
> --- a/lib/kobject_uevent.c
> +++ b/lib/kobject_uevent.c
> @@ -703,9 +703,13 @@ static int uevent_net_init(struct net *net)
>  
>  	net->uevent_sock = ue_sk;
>  
> -	mutex_lock(&uevent_sock_mutex);
> -	list_add_tail(&ue_sk->list, &uevent_sock_list);
> -	mutex_unlock(&uevent_sock_mutex);
> +	/* Restrict uevents to initial user namespace. */
> +	if (sock_net(ue_sk->sk)->user_ns == &init_user_ns) {
> +		mutex_lock(&uevent_sock_mutex);
> +		list_add_tail(&ue_sk->list, &uevent_sock_list);
> +		mutex_unlock(&uevent_sock_mutex);
> +	}
> +
>  	return 0;
>  }
>  
> @@ -713,9 +717,11 @@ static void uevent_net_exit(struct net *net)
>  {
>  	struct uevent_sock *ue_sk = net->uevent_sock;
>  
> -	mutex_lock(&uevent_sock_mutex);
> -	list_del(&ue_sk->list);
> -	mutex_unlock(&uevent_sock_mutex);
> +	if (sock_net(ue_sk->sk)->user_ns == &init_user_ns) {
> +		mutex_lock(&uevent_sock_mutex);
> +		list_del(&ue_sk->list);
> +		mutex_unlock(&uevent_sock_mutex);
> +	}
>  
>  	netlink_kernel_release(ue_sk->sk);
>  	kfree(ue_sk);
