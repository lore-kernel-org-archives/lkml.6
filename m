Return-Path: <ebiederm@xmission.com>
X-Google-Smtp-Source: AB8JxZrHGrYrcE81LQqiiy3quaw9zX8DPj+KCriZsn31WaHDzp5Mhn6iMpVN5cI6KjpQM5HLqIlB
ARC-Seal: i=1; a=rsa-sha256; t=1524789355; cv=none;
        d=google.com; s=arc-20160816;
        b=lGJvcQRFSlwL7/devMWd1Y5mCjwN3t/8Ej7Wz9SLoSVCVZBmsgXznHx+/Gm/3MFQ+o
         A/d+seoOatvAZ5m0DpCjcYsmGdj+LB9S+R/tjfASvgoiP8PuEsNzPc+HeO7GDrptLjkm
         zs6cpV0X1A/7MfXxzxv5YEAvhgacwh1pBotqZbX+SeJCd0UDVCt3bI+uwnj0PkpKBF/b
         aEwE1D5vdLb424DM6+DVCT/Ti4Y1friC0gCUeZaEJs5pna8z31TIiwvMA9HhS7r41RIk
         OLYtqIjt3Oi/75bKTtySBv3343gzvBsvP2BAxS18aGdpMb1qXuezQBzCgtalfFmkttJA
         FpqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:mime-version:user-agent:message-id:in-reply-to:date
         :references:cc:to:from:arc-authentication-results;
        bh=HjqGtFuTbb4sO4NdGS0cPG7GMekjBOQBNECO2BIwALc=;
        b=GNnXx83kB24U3gRrwlOJcd6IRopMSfbC5Jq7IOl6sIOCVFAfI2iEtxxUgkCIed+WXi
         mQH/WCWco38QW41SCG2SdsjGD8Twa4j/kMrr6HWTMFM1j1WoaWbT18IzoH+YxcvAaL0m
         g+Ta3NftLCWgs1KheTzFdzFuOJBzRhy4ikQwU0aK9okkXIDMlYW0nYW8MYwHcTv2x1QZ
         hKUsgwZHCKBUW2jeVbMAR0yBfBtQXm9/77e/OUyWie13ngIMdmx8lDE2YrZ28SMKQ+Xu
         aAk4Stlc02ypRMqehNs/jeEEjreyYoP2iWiXNew1LeBrwj9DDI0IG7hNppIk0iD33LOD
         2v4w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.232 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.232 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christian Brauner <christian.brauner@canonical.com>
Cc: David Miller <davem@davemloft.net>,  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,  avagin@virtuozzo.com,  ktkhai@virtuozzo.com,  serge@hallyn.com,  gregkh@linuxfoundation.org
References: <20180424204335.12904-1-christian.brauner@ubuntu.com>
	<20180424204335.12904-2-christian.brauner@ubuntu.com>
	<87po2oz0s8.fsf@xmission.com>
	<CAPP7u0WH9w26Y9ai-EQTTeq7Rz_=7u2-=t4nhHmjwh-UAiyqeQ@mail.gmail.com>
	<87wowww6p8.fsf@xmission.com> <20180426161353.GA2014@gmail.com>
	<871sf1q5ig.fsf@xmission.com> <20180426170324.GA10061@gmail.com>
	<878t99opvd.fsf@xmission.com> <20180426212744.GA30270@gmail.com>
Date: Thu, 26 Apr 2018 19:35:47 -0500
In-Reply-To: <20180426212744.GA30270@gmail.com> (Christian Brauner's message
	of "Thu, 26 Apr 2018 23:27:45 +0200")
Message-ID: <87vacdbi58.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fBrMd-0005gT-GN;;;mid=<87vacdbi58.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/v/tWWMX93bM/IvGxIYN8Nhs++bo4mDnk=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christian Brauner <christian.brauner@canonical.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1497 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 2.9 (0.2%), b_tie_ro: 2.0 (0.1%), parse: 1.84 (0.1%),
	extract_message_metadata: 38 (2.5%), get_uri_detail_list: 10 (0.7%),
	tests_pri_-1000: 12 (0.8%), tests_pri_-950: 2.1 (0.1%), tests_pri_-900: 1.63
	(0.1%), tests_pri_-400: 58 (3.9%), check_bayes: 56 (3.7%), b_tokenize: 26
	(1.7%), b_tok_get_all: 14 (0.9%), b_comp_prob: 8 (0.5%), b_tok_touch_all: 3.3
	(0.2%), b_finish: 0.78 (0.1%), tests_pri_0: 1367 (91.3%),
	check_dkim_signature: 1.09 (0.1%), check_dkim_adsp: 4.9 (0.3%),
	tests_pri_500: 7 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH net-next 1/2 v2] netns: restrict uevents
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598661751720131852?=
X-GMAIL-MSGID: =?utf-8?q?1598857523623234448?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Christian Brauner <christian.brauner@canonical.com> writes:

> On Thu, Apr 26, 2018 at 12:10:30PM -0500, Eric W. Biederman wrote:
>> Christian Brauner <christian.brauner@canonical.com> writes:
>> 
>> > On Thu, Apr 26, 2018 at 11:47:19AM -0500, Eric W. Biederman wrote:
>> >> Christian Brauner <christian.brauner@canonical.com> writes:
>> >> 
>> >> > On Tue, Apr 24, 2018 at 06:00:35PM -0500, Eric W. Biederman wrote:
>> >> >> Christian Brauner <christian.brauner@canonical.com> writes:
>> >> >> 
>> >> >> > On Wed, Apr 25, 2018, 00:41 Eric W. Biederman <ebiederm@xmission.com> wrote:
>> >> >> >
>> >> >> >  Bah. This code is obviously correct and probably wrong.
>> >> >> >
>> >> >> >  How do we deliver uevents for network devices that are outside of the
>> >> >> >  initial user namespace? The kernel still needs to deliver those.
>> >> >> >
>> >> >> >  The logic to figure out which network namespace a device needs to be
>> >> >> >  delivered to is is present in kobj_bcast_filter. That logic will almost
>> >> >> >  certainly need to be turned inside out. Sign not as easy as I would
>> >> >> >  have hoped.
>> >> >> >
>> >> >> > My first patch that we discussed put additional filtering logic into kobj_bcast_filter for that very reason. But I can move that logic
>> >> >> > out and come up with a new patch.
>> >> >> 
>> >> >> I may have mis-understood.
>> >> >> 
>> >> >> I heard and am still hearing additional filtering to reduce the places
>> >> >> the packet is delievered.
>> >> >> 
>> >> >> I am saying something needs to change to increase the number of places
>> >> >> the packet is delivered.
>> >> >> 
>> >> >> For the special class of devices that kobj_bcast_filter would apply to
>> >> >> those need to be delivered to netowrk namespaces  that are no longer on
>> >> >> uevent_sock_list.
>> >> >> 
>> >> >> So the code fundamentally needs to split into two paths.  Ordinary
>> >> >> devices that use uevent_sock_list.  Network devices that are just
>> >> >> delivered in their own network namespace.
>> >> >> 
>> >> >> netlink_broadcast_filtered gets to go away completely.
>> >> >
>> >> > The split *might* make sense but I think you're wrong about removing the
>> >> > kobj_bcast_filter. The current filter doesn't operate on the uevent
>> >> > socket in uevent_sock_list itself it rather operates on the sockets in
>> >> > mc_list. And if socket in mc_list can have a different network namespace
>> >> > then the uevent_socket itself then your way won't work. That's why my
>> >> > original patch added additional filtering in there. The way I see it we
>> >> > need something like:
>> >> 
>> >> We already filter the sockets in the mc_list by network namespace.
>> >
>> > Oh really? That's good to know. I haven't found where in the code this
>> > actually happens. I thought that when netlink_bind() is called anyone
>> > could register themselves in mc_list.
>> 
>> The code in af_netlink.c does:
>> > static void do_one_broadcast(struct sock *sk,
>> > 				    struct netlink_broadcast_data *p)
>> > {
>> > 	struct netlink_sock *nlk = nlk_sk(sk);
>> > 	int val;
>> > 
>> > 	if (p->exclude_sk == sk)
>> > 		return;
>> > 
>> > 	if (nlk->portid == p->portid || p->group - 1 >= nlk->ngroups ||
>> > 	    !test_bit(p->group - 1, nlk->groups))
>> > 		return;
>> > 
>> > 	if (!net_eq(sock_net(sk), p->net)) {
>>             ^^^^^^^^^^^^ Here
>> > 		if (!(nlk->flags & NETLINK_F_LISTEN_ALL_NSID))
>> > 			return;
>>                 ^^^^^^^^^^^ Here
>> > 
>> > 		if (!peernet_has_id(sock_net(sk), p->net))
>> > 			return;
>> > 
>> > 		if (!file_ns_capable(sk->sk_socket->file, p->net->user_ns,
>> > 				     CAP_NET_BROADCAST))
>> > 			return;
>> > 	}
>> 
>> Which if you are not a magic NETLINK_F_LISTEN_ALL_NSID socket filters
>> you out if you are the wrong network namespace.
>> 
>> 
>> >> When a packet is transmitted with netlink_broadcast it is only
>> >> transmitted within a single network namespace.
>> >> 
>> >> Even in the case of a NETLINK_F_LISTEN_ALL_NSID socket the skb is tagged
>> >> with it's source network namespace so no confusion will result, and the
>> >> permission checks have been done to make it safe. So you can safely
>> >> ignore that case.  Please ignore that case.  It only needs to be
>> >> considered if refactoring af_netlink.c
>> >> 
>> >> When I added netlink_broadcast_filtered I imagined that we would need
>> >> code that worked across network namespaces that worked for different
>> >> namespaces.   So it looked like we would need the level of granularity
>> >> that you can get with netlink_broadcast_filtered.  It turns out we don't
>> >> and that it was a case of over design.  As the only split we care about
>> >> is per network namespace there is no need for
>> >> netlink_broadcast_filtered.
>> >> 
>> >> > init_user_ns_broadcast_filtered(uevent_sock_list, kobj_bcast_filter);
>> >> > user_ns_broadcast_filtered(uevent_sock_list,kobj_bcast_filter);
>> >> >
>> >> > The question that remains is whether we can rely on the network
>> >> > namespace information we can gather from the kobject_ns_type_operations
>> >> > to decide where we want to broadcast that event to. So something
>> >> > *like*:
>> >> 
>> >> We can.  We already do.  That is what kobj_bcast_filter implements.
>> >> 
>> >> > 	ops = kobj_ns_ops(kobj);
>> >> > 	if (!ops && kobj->kset) {
>> >> > 		struct kobject *ksobj = &kobj->kset->kobj;
>> >> > 		if (ksobj->parent != NULL)
>> >> > 			ops = kobj_ns_ops(ksobj->parent);
>> >> > 	}
>> >> >
>> >> > 	if (ops && ops->netlink_ns && kobj->ktype->namespace)
>> >> > 		if (ops->type == KOBJ_NS_TYPE_NET)
>> >> > 			net = kobj->ktype->namespace(kobj);
>> >> 
>> >> Please note the only entry in the enumeration in the kobj_ns_type
>> >> enumeration other than KOBJ_NS_TYPE_NONE is KOBJ_NS_TYPE_NET.  So the
>> >> check for ops->type in this case is redundant.
>> >
>> > Yes, I know the reason for doing it explicitly is to block the case
>> > where kobjects get tagged with other namespaces. So we'd need to be
>> > vigilant should that ever happen but fine.
>> 
>> It is fine to keep the check.
>> 
>> I was intending to point out that it is much more likely that we remove
>> the enumeration and remove some of the extra abstraction, than another
>> namespace is implemented there.
>> 
>> >> That is something else that could be simplifed.  At the time it was the
>> >> necessary to get the sysfs changes merged.
>> >> 
>> >> > 	if (!net || net->user_ns == &init_user_ns)
>> >> > 		ret = init_user_ns_broadcast(env, action_string, devpath);
>> >> > 	else
>> >> > 		ret = user_ns_broadcast(net->uevent_sock->sk, env,
>> >> > 					action_string, devpath);
>> >> 
>> >> Almost.
>> >> 
>> >> 	if (!net)
>> >>         	kobject_uevent_net_broadcast(kobj, env, action_string,
>> >>         					dev_path);
>> >> 	else
>> >>         	netlink_broadcast(net->uevent_sock->sk, skb, 0, 1, GFP_KERNEL);
>> >> 
>> >> 
>> >> I am handwaving to get the skb in the netlink_broadcast case but that
>> >> should be enough for you to see what I am thinking.
>> >
>> > I have added a helper alloc_uevent_skb() that can be used in both cases.
>> >
>> > static struct sk_buff *alloc_uevent_skb(struct kobj_uevent_env *env,
>> > 					const char *action_string,
>> > 					const char *devpath)
>> > {
>> > 	struct sk_buff *skb = NULL;
>> > 	char *scratch;
>> > 	size_t len;
>> >
>> > 	/* allocate message with maximum possible size */
>> > 	len = strlen(action_string) + strlen(devpath) + 2;
>> > 	skb = alloc_skb(len + env->buflen, GFP_KERNEL);
>> > 	if (!skb)
>> > 		return NULL;
>> >
>> > 	/* add header */
>> > 	scratch = skb_put(skb, len);
>> > 	sprintf(scratch, "%s@%s", action_string, devpath);
>> >
>> > 	skb_put_data(skb, env->buf, env->buflen);
>> >
>> > 	NETLINK_CB(skb).dst_group = 1;
>> >
>> > 	return skb;
>> > }
>> >
>> >> 
>> >> My only concern with the above is that we almost certainly need to fix
>> >> the credentials on the skb so that userspace does not drop the packet
>
> I guess we simply want:
> 	if (user_ns != &init_user_ns) {
> 		NETLINK_CB(skb).creds.uid = (kuid_t)0;
> 		NETLINK_CB(skb).creds.gid = kgid_t)0;
> 	}

I believe the above is what we already have.

> instead of the more complicated and - imho wrong:
>
> 	if (user_ns != &init_user_ns) {
> 		/* fix credentials for udev running in user namespace */
> 		kuid_t uid = NETLINK_CB(skb).creds.uid;
> 		kgid_t gid = NETLINK_CB(skb).creds.gid;
> 		NETLINK_CB(skb).creds.uid = from_kuid_munged(user_ns, uid);
> 		NETLINK_CB(skb).creds.gid = from_kgid_munged(user_ns, gid);
> 	}

The above is most definitely wrong as we store kuids and kgids in
"NETLINK_CB(skb).creds".

I am pretty certain what we want is:
	kuid_t root_uid = make_kuid(net->user_ns, 0);
        kgid_g root_gid = make_kgid(net->user_ns, 0);
        if (!uid_valid(root_uid))
        	root_uid = GLOBAL_ROOT_UID;
	if (!gid_valid(root_gid))
        	root_gid = GLOBAL_ROOT_GID;
	NETLINK_CB(skb).creds.uid = root_uid;
        NETLINK_CB(skb).creds.gid = root_gid;

Let's be careful and only fix this for the networking uevents please.
We want the other onces to just go away.

The networking uevents we have to fix or they will be gone completely.

Eric
