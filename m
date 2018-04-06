Return-Path: <ebiederm@xmission.com>
X-Google-Smtp-Source: AIpwx4/u7HhetMkYt3NRAHOjZTbf/kwYGWMJ2ckhm54mRVxXqydmhR9K9NEgR+q50uO6f6gE/Vjh
ARC-Seal: i=1; a=rsa-sha256; t=1522987263; cv=none;
        d=google.com; s=arc-20160816;
        b=ELjuCv9JPclzlRtoE85wib16DHNbGm+CvoG5+5zmFd0eEpq0Ahwj/r8M3pBVMheqpT
         HgIYPztEMmWq7OdLIfVAAAtSgYcFPogsCBBLtN0BoI6JMnuu0Pha5+iKNYM7SemxfxVg
         oyi1cEsLZRHPGGzp901aCuAHEmN02uxLCl1/uUJ3UBZ/fj2uaGuQxKJ49XBlIMAy4AxI
         tOGUn6wN5SuIJpeWBk2TVRFBBu57lubdgQyDWBwTeErbmLaxBKQVy8lS8lTFLM33U6Oo
         ssFJOqrQlCI43PWSn+y3gf1evxNOZC0g8f+ktYdvyya61UepFdLnT+W0igGNwazJqtLk
         2uQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:mime-version:user-agent:message-id:in-reply-to:date
         :references:cc:to:from:arc-authentication-results;
        bh=DFWZTNwlbdxqfB9KICrSRPE9yO2bZzimrv+F3hgd8HE=;
        b=mHEtvTsAj+XSzfiMcv6E00qGhtxl7HSQdsuVdGQFrFhlr/5SSPwRQEMzoElLNhJdUU
         llqJ9RnHcAcYfsjygZrQgbDivDIzQIoHkxmAFrUo+736gtvt7nTo1LOS8PUANDuXd3+a
         BJ/YH+HAu/ryCDmCvPeDpBfp6nHuZPKEoko4vlhG8OyZPbSLIblwKuqptmyRA5AA201b
         4iicTkKCO22Z7osr4E7fi4ei1QbP5ZRR09J+WT8Py6caHHMpfJ/xmMadf2gxMty8JjdK
         KSTD+RoMxLo1Q9LJ0cGgtJIRK0x3gZA/ZpTiKO38KPFTecufjwTgCVVY8ElmiCHNs9jQ
         x5mQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.233 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.233 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christian Brauner <christian.brauner@canonical.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>,  davem@davemloft.net,  gregkh@linuxfoundation.org,  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,  avagin@virtuozzo.com,  serge@hallyn.com
References: <20180404194857.29375-1-christian.brauner@ubuntu.com>
	<442e89b8-e947-6eeb-1bcb-fa28f22a25f0@virtuozzo.com>
	<20180405140709.GA1697@gmail.com>
	<941de2b9-332f-75fc-f8ac-4059a9b5426f@virtuozzo.com>
	<20180405144130.GB26043@gmail.com>
Date: Thu, 05 Apr 2018 22:59:49 -0500
In-Reply-To: <20180405144130.GB26043@gmail.com> (Christian Brauner's message
	of "Thu, 5 Apr 2018 16:41:30 +0200")
Message-ID: <87in953ryi.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f4IYe-0008CC-8r;;;mid=<87in953ryi.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.140.30;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19d5biHBspHqpbwHJqjQ38PF4I3/Z4XKxk=
X-SA-Exim-Connect-IP: 97.119.140.30
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christian Brauner <christian.brauner@canonical.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 497 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 3.0 (0.6%), b_tie_ro: 1.95 (0.4%), parse: 1.05 (0.2%),
	extract_message_metadata: 17 (3.4%), get_uri_detail_list: 4.5 (0.9%),
	tests_pri_-1000: 6 (1.2%), tests_pri_-950: 1.24 (0.3%), tests_pri_-900: 1.02
	(0.2%), tests_pri_-400: 35 (7.1%), check_bayes: 34 (6.9%), b_tokenize: 14
	(2.7%), b_tok_get_all: 12 (2.3%), b_comp_prob: 3.5 (0.7%), b_tok_touch_all:
	3.7 (0.7%), b_finish: 0.58 (0.1%), tests_pri_0: 423 (85.2%),
	check_dkim_signature: 0.79 (0.2%), check_dkim_adsp: 3.1 (0.6%),
	tests_pri_500: 5 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH net-next] netns: filter uevents correctly
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596846368169451603?=
X-GMAIL-MSGID: =?utf-8?q?1596967892935623531?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Christian Brauner <christian.brauner@canonical.com> writes:

> On Thu, Apr 05, 2018 at 05:26:59PM +0300, Kirill Tkhai wrote:
>> On 05.04.2018 17:07, Christian Brauner wrote:
>> > On Thu, Apr 05, 2018 at 04:01:03PM +0300, Kirill Tkhai wrote:
>> >> On 04.04.2018 22:48, Christian Brauner wrote:
>> >>> commit 07e98962fa77 ("kobject: Send hotplug events in all network namespaces")
>> >>>
>> >>> enabled sending hotplug events into all network namespaces back in 2010.
>> >>> Over time the set of uevents that get sent into all network namespaces has
>> >>> shrunk. We have now reached the point where hotplug events for all devices
>> >>> that carry a namespace tag are filtered according to that namespace.
>> >>>
>> >>> Specifically, they are filtered whenever the namespace tag of the kobject
>> >>> does not match the namespace tag of the netlink socket. One example are
>> >>> network devices. Uevents for network devices only show up in the network
>> >>> namespaces these devices are moved to or created in.
>> >>>
>> >>> However, any uevent for a kobject that does not have a namespace tag
>> >>> associated with it will not be filtered and we will *try* to broadcast it
>> >>> into all network namespaces.
>> >>>
>> >>> The original patchset was written in 2010 before user namespaces were a
>> >>> thing. With the introduction of user namespaces sending out uevents became
>> >>> partially isolated as they were filtered by user namespaces:
>> >>>
>> >>> net/netlink/af_netlink.c:do_one_broadcast()
>> >>>
>> >>> if (!net_eq(sock_net(sk), p->net)) {
>> >>>         if (!(nlk->flags & NETLINK_F_LISTEN_ALL_NSID))
>> >>>                 return;
>> >>>
>> >>>         if (!peernet_has_id(sock_net(sk), p->net))
>> >>>                 return;
>> >>>
>> >>>         if (!file_ns_capable(sk->sk_socket->file, p->net->user_ns,
>> >>>                              CAP_NET_BROADCAST))
>> >>>         j       return;
>> >>> }
>> >>>
>> >>> The file_ns_capable() check will check whether the caller had
>> >>> CAP_NET_BROADCAST at the time of opening the netlink socket in the user
>> >>> namespace of interest. This check is fine in general but seems insufficient
>> >>> to me when paired with uevents. The reason is that devices always belong to
>> >>> the initial user namespace so uevents for kobjects that do not carry a
>> >>> namespace tag should never be sent into another user namespace. This has
>> >>> been the intention all along. But there's one case where this breaks,
>> >>> namely if a new user namespace is created by root on the host and an
>> >>> identity mapping is established between root on the host and root in the
>> >>> new user namespace. Here's a reproducer:
>> >>>
>> >>>  sudo unshare -U --map-root
>> >>>  udevadm monitor -k
>> >>>  # Now change to initial user namespace and e.g. do
>> >>>  modprobe kvm
>> >>>  # or
>> >>>  rmmod kvm
>> >>>
>> >>> will allow the non-initial user namespace to retrieve all uevents from the
>> >>> host. This seems very anecdotal given that in the general case user
>> >>> namespaces do not see any uevents and also can't really do anything useful
>> >>> with them.
>> >>>
>> >>> Additionally, it is now possible to send uevents from userspace. As such we
>> >>> can let a sufficiently privileged (CAP_SYS_ADMIN in the owning user
>> >>> namespace of the network namespace of the netlink socket) userspace process
>> >>> make a decision what uevents should be sent.
>> >>>
>> >>> This makes me think that we should simply ensure that uevents for kobjects
>> >>> that do not carry a namespace tag are *always* filtered by user namespace
>> >>> in kobj_bcast_filter(). Specifically:
>> >>> - If the owning user namespace of the uevent socket is not init_user_ns the
>> >>>   event will always be filtered.
>> >>> - If the network namespace the uevent socket belongs to was created in the
>> >>>   initial user namespace but was opened from a non-initial user namespace
>> >>>   the event will be filtered as well.
>> >>> Put another way, uevents for kobjects not carrying a namespace tag are now
>> >>> always only sent to the initial user namespace. The regression potential
>> >>> for this is near to non-existent since user namespaces can't really do
>> >>> anything with interesting devices.
>> >>>
>> >>> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
>> >>> ---
>> >>>  lib/kobject_uevent.c | 10 +++++++++-
>> >>>  1 file changed, 9 insertions(+), 1 deletion(-)
>> >>>
>> >>> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
>> >>> index 15ea216a67ce..cb98cddb6e3b 100644
>> >>> --- a/lib/kobject_uevent.c
>> >>> +++ b/lib/kobject_uevent.c
>> >>> @@ -251,7 +251,15 @@ static int kobj_bcast_filter(struct sock *dsk, struct sk_buff *skb, void *data)
>> >>>  		return sock_ns != ns;
>> >>>  	}
>> >>>  
>> >>> -	return 0;
>> >>> +	/*
>> >>> +	 * The kobject does not carry a namespace tag so filter by user
>> >>> +	 * namespace below.
>> >>> +	 */
>> >>> +	if (sock_net(dsk)->user_ns != &init_user_ns)
>> >>> +		return 1;
>> >>> +
>> >>> +	/* Check if socket was opened from non-initial user namespace. */
>> >>> +	return sk_user_ns(dsk) != &init_user_ns;
>> >>>  }
>> >>>  #endif
>> >>
>> >> So, this prohibits to listen events of all devices except network-related
>> >> in containers? If it's so, I don't think it's a good solution. Uevents is not
>> > 
>> > No, this is not correct: As it is right now *without my patch* no
>> > non-initial user namespace is receiving *any uevents* but those
>> > specifically namespaced such as those for network devices. This patch
>> > doesn't change that at all. The commit message outlines this in detail
>> > how this comes about.
>> > There is only one case where this currently breaks and this is as I
>> > outlined explicitly in my commit message when you create a new user
>> > namespace and map container(0) -> host(0). This patch fixes this.
>> 
>> Could you please point the place, where non-initial user namespaces are filtered?
>> I only see the kobj_bcast_filter() logic, and it used to return 0, which means "accepted".
>> Now it will return 1 sometimes.
>
> Oh sure, it's in the commit message though. The callchain is
> lib/kobject_uevent.c:kobject_uevent_net_broadcast() ->
> nnet/netlink/af_netlink.c:netlink_broadcast_filtered() ->
> net/netlink/af_netlink.c:do_one_broadcast():
>
> This codepiece will check whether the openened socket holds
> CAP_NET_BROADCAST in the user namespace of the target network namespace
> which it won't because we don't have device namespaces and all devices
> belong to the initial set of namespaces.
>
>         if (!file_ns_capable(sk->sk_socket->file, p->net->user_ns,
>                              CAP_NET_BROADCAST))
>         j       return;
>

The above that only applies if someone has set NETLINK_F_LISTEN_ALL_NSID
on their socket and has had someone with the appropriate privileges
assign a peerrnetid.

All of which is to say that file_ns_capable is not nearly as applicable
as it might be, and if you can pass the other two checks I think it is
pointless (because the peernet attributes are not generated for
kobj_uevents) but valid to receive events from outside your network
namespace.


I might be missing something but I don't see anything excluding network
namespaces owned by !init_user_ns excluded from the kobject_uevent
logic.

The uevent_sock_list has one entry per network namespace. And
kobject_uevent_net_broacast appears to walk each one.

I had a memory of filtering uevent messages and I had a memory
that the netlink_has_listeners had a per network namespace effect.
Neither seems true from my inspection of the code tonight.

If we are not filtering ordinary uevents at least at the user namespace
level that does seem to be at least a nuisance.


Christian can you dig a little deeper into this.  I have a feeling that
there are some real efficiency improvements that we could make to
kobject_uevent_net_broadcast if nothing else.

Perhaps you could see where uevents are broadcast by poking
the sysfs uevent of an existing device, and triggering a retransmit.

Eric
