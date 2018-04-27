Return-Path: <ebiederm@xmission.com>
X-Google-Smtp-Source: AB8JxZoWlRjh4yBdyX7Mhi6uw8HyNCi1oroe37Blx7UrP4cwVv4ERjXf/m7zsH0wAy77q1jGxaEo
ARC-Seal: i=1; a=rsa-sha256; t=1524846638; cv=none;
        d=google.com; s=arc-20160816;
        b=pye8OBSMUkRvT43Jtm6ALhZzB/XZOtjGwbRdZXNgRN262XdiFieQA4X1ABSz7l1JAT
         3Zq8+4ijmUy1A+4ag4jeQv5NhlRhvSGGTuvLDEqIxv3MGNs+lKDGhKtA2ItdbSj5PPEz
         qU4VYf20+tlosVYdRkfTYkjUaC9L3B0y89w4BUleEiPrWpC3px1nZmkghoB3jNs3YUUN
         9SGqPkT+DIr7wBkFeoOV5z6cfgTWHBDUOJT+AXT1r+SDIXclip12buzveGOWn8BA1oVX
         eeUwVxfsAzAagHN2tqof7EhTUAu/oQw55ppSc6RXbCHdSwz+zbz6L65WnZiTcVkwfYCp
         sPsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:mime-version:user-agent:message-id:in-reply-to:date
         :references:cc:to:from:arc-authentication-results;
        bh=CxH8/iJp6ErkanV7YzdWQ1W+dCIFtedjL4kA32UGy7g=;
        b=cuKA4Ik3DsRTrVTtEUx3GF55KfLB8ON/9OhOIIR2zFBZAqCt7gDOUcRGMVFM7cUxsa
         7O9+teyRT0HA/+vo7cJXA26/TXtyvxuPAIPas1CPJZ9yzhWsoavNfe+G/VLryzyBGZl1
         WCwF/VFnI8zC6Xd6ekEgeS7d0eXvmyvzX9Jl/roPSXDKUZXemcEYjwv9LNR5mXR5B74i
         OmTn5eDL8frYwB0pay10XRLub/p9K3eW7WsJJ3WDk0aGKq84lt6Oc3eidRa9zrl74alm
         5hy3uh5DGxxsFfSroT9ElifpZ0Myd0u/L/5EOd/5HV8pj5v8wK2pLzR1RuDj7c1MZ7z3
         8nZw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.231 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.231 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christian Brauner <christian.brauner@ubuntu.com>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,  avagin@virtuozzo.com,  ktkhai@virtuozzo.com,  serge@hallyn.com,  gregkh@linuxfoundation.org
References: <20180427102306.8617-1-christian.brauner@ubuntu.com>
	<20180427102306.8617-3-christian.brauner@ubuntu.com>
Date: Fri, 27 Apr 2018 11:30:26 -0500
In-Reply-To: <20180427102306.8617-3-christian.brauner@ubuntu.com> (Christian
	Brauner's message of "Fri, 27 Apr 2018 12:23:06 +0200")
Message-ID: <87po2k7gt9.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fC6GU-0001B7-Sg;;;mid=<87po2k7gt9.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/kt/3ROK4orS/RBoLdH9UPvLWowxxqmb8=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4134]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christian Brauner <christian.brauner@ubuntu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 149 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 3.2 (2.1%), b_tie_ro: 2.3 (1.6%), parse: 0.79 (0.5%),
	extract_message_metadata: 10 (6.7%), get_uri_detail_list: 1.01 (0.7%),
	tests_pri_-1000: 4.8 (3.3%), tests_pri_-950: 1.02 (0.7%), tests_pri_-900:
	0.88 (0.6%), tests_pri_-400: 16 (10.7%), check_bayes: 15 (10.1%), b_tokenize:
	4.0 (2.7%), b_tok_get_all: 5 (3.6%), b_comp_prob: 1.18 (0.8%),
	b_tok_touch_all: 2.8 (1.9%), b_finish: 0.62 (0.4%), tests_pri_0: 106 (71.1%),
	check_dkim_signature: 0.37 (0.3%), check_dkim_adsp: 4.8 (3.2%),
	tests_pri_500: 3.2 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH net-next 2/2 v3] netns: restrict uevents
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598894617083131162?=
X-GMAIL-MSGID: =?utf-8?q?1598917588927836516?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Christian Brauner <christian.brauner@ubuntu.com> writes:
> ---
>  lib/kobject_uevent.c | 140 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 99 insertions(+), 41 deletions(-)
>
> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> index c3cb110f663b..d8ce5e6d83af 100644
> --- a/lib/kobject_uevent.c
> +++ b/lib/kobject_uevent.c
>  
> +static int uevent_net_broadcast_tagged(struct sock *usk,
> +				       struct kobj_uevent_env *env,
> +				       const char *action_string,
> +				       const char *devpath)
> +{
> +	struct user_namespace *owning_user_ns = sock_net(usk)->user_ns;
> +	struct sk_buff *skb = NULL;
> +	int ret;
> +
> +	skb = alloc_uevent_skb(env, action_string, devpath);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	/* fix credentials */
> +	if (owning_user_ns != &init_user_ns) {

Nit: This test is just a performance optimization as such is not
      necessary.  That is we can safely unconditionally set the
      credentials this way.

> +		struct netlink_skb_parms *parms = &NETLINK_CB(skb);
> +		kuid_t root_uid;
> +		kgid_t root_gid;
> +
> +		/* fix uid */
> +		root_uid = make_kuid(owning_user_ns, 0);
> +		if (!uid_valid(root_uid))
> +			root_uid = GLOBAL_ROOT_UID;
> +		parms->creds.uid = root_uid;
> +
> +		/* fix gid */
> +		root_gid = make_kgid(owning_user_ns, 0);
> +		if (!gid_valid(root_gid))
> +			root_gid = GLOBAL_ROOT_GID;
> +		parms->creds.gid = root_gid;
> +	}
> +
> +	ret = netlink_broadcast(usk, skb, 0, 1, GFP_KERNEL);
> +	/* ENOBUFS should be handled in userspace */
> +	if (ret == -ENOBUFS || ret == -ESRCH)
> +		ret = 0;
> +
> +	return ret;
> +}
> +#endif
