Return-Path: <ebiederm@xmission.com>
X-Google-Smtp-Source: AIpwx49nerTbLpx/wkL++uv+SD2JnIobKCeFW+4FbxsT/6JPzFdcd4dUk1pNYEP5VpdmvlVD/vs5
ARC-Seal: i=1; a=rsa-sha256; t=1523471920; cv=none;
        d=google.com; s=arc-20160816;
        b=07dafIKKxR1P03617rBGQ6v03YMQDy8+UX0P3VqI07zlY79ZuT5WDsiB+l9+ZYxZJ7
         A291U1vf3Wvq/5Gf3Mh3BPvBKQbiLo18qibwzuZF0SleG8yBrK8R+iVqwTE+dofJA7OV
         lbKkzTmE8JcA/NgmlPqeflaJ1avNHf2CPlCTYo2Kq7EHOLKIVJjlpy4RqxUt8HqPHSCC
         klVfeQqfVf1AixCRpWbeb/dfMVnWutZqIGF1x+fcv7H6YiyM1zBdExAnuAcw6QrWOww6
         4Q6adz8OtH7V20StXICIjipZtlEYgRVv6EbCDvachNb9b7WqOkkbKrIhg4grHG7V6IkY
         /+zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:mime-version:user-agent:message-id:in-reply-to:date
         :references:cc:to:from:arc-authentication-results;
        bh=W4fWEwnmLE9cLtUEnwVCkRhzp50MdYN/zshB8+bBcTs=;
        b=V5tQ25HW+iioXMjuCVFruJj/vZ6CmKwEgF5W6jr2K9SUcPIah1kLdYq2td+V6RFId/
         suAtEa2nsmO7q3e9LgQnoB/MPdQYCv7SObKgKV3BPDxaEY0U04OHZGTItMmvBUCKoqsh
         43tXYzjamofGckKHtNyOjycLjzEWgR+dPLiF9PCYvqV7IHE7BmJ1bmh3ngUBV7Ho7O+i
         ZRT3iLyoOJs32Ttatpu1Jx5M8U+VEJFay8DxKVb4bt49Zi56s/JebYvMPxbklSlT/GOy
         /U0lQEKlv8t8BOcceCPH43V37GNs5KbXNBeS7/TvrnDN9gMB9tW4/SE498iOT8MdslsJ
         gIMA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.231 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.231 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christian Brauner <christian.brauner@canonical.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>,  davem@davemloft.net,  gregkh@linuxfoundation.org,  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,  avagin@virtuozzo.com,  serge@hallyn.com
References: <20180405140709.GA1697@gmail.com>
	<941de2b9-332f-75fc-f8ac-4059a9b5426f@virtuozzo.com>
	<20180405144130.GB26043@gmail.com> <87in953ryi.fsf@xmission.com>
	<20180409154627.GA15157@gmail.com> <878t9wx8xw.fsf@xmission.com>
	<20180410143515.GA14186@gmail.com> <87in8zumpd.fsf@xmission.com>
	<20180411090907.GA20340@gmail.com> <87tvshlms1.fsf@xmission.com>
	<20180411170333.GA4319@gmail.com>
Date: Wed, 11 Apr 2018 13:37:18 -0500
In-Reply-To: <20180411170333.GA4319@gmail.com> (Christian Brauner's message of
	"Wed, 11 Apr 2018 19:03:35 +0200")
Message-ID: <87efjllhcx.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f6Kdd-0003nn-69;;;mid=<87efjllhcx.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.140.30;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18f8n9o+tXqwB5o/cO/wmBcsbbv9rsX+b0=
X-SA-Exim-Connect-IP: 97.119.140.30
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4963]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christian Brauner <christian.brauner@canonical.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2280 ms - load_scoreonly_sql: 0.14 (0.0%),
	signal_user_changed: 16 (0.7%), b_tie_ro: 14 (0.6%), parse: 1.71 (0.1%),
	extract_message_metadata: 69 (3.0%), get_uri_detail_list: 3.8 (0.2%),
	tests_pri_-1000: 27 (1.2%), tests_pri_-950: 2.3 (0.1%), tests_pri_-900: 1.75
	(0.1%), tests_pri_-400: 68 (3.0%), check_bayes: 54 (2.4%), b_tokenize: 17
	(0.7%), b_tok_get_all: 16 (0.7%), b_comp_prob: 4.4 (0.2%), b_tok_touch_all:
	2.5 (0.1%), b_finish: 0.83 (0.0%), tests_pri_0: 2050 (89.9%),
	check_dkim_signature: 1.13 (0.0%), check_dkim_adsp: 8 (0.3%), tests_pri_500:
	24 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH net-next] netns: filter uevents correctly
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596846368169451603?=
X-GMAIL-MSGID: =?utf-8?q?1597476092966915387?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Christian Brauner <christian.brauner@canonical.com> writes:

> On Wed, Apr 11, 2018 at 11:40:14AM -0500, Eric W. Biederman wrote:
>> Christian Brauner <christian.brauner@canonical.com> writes:
>> > Yeah, agreed.
>> > But I think the patch is not complete. To guarantee that no non-initial
>> > user namespace actually receives uevents we need to:
>> > 1. only sent uevents to uevent sockets that are located in network
>> >    namespaces that are owned by init_user_ns
>> > 2. filter uevents that are sent to sockets in mc_list that have opened a
>> >    uevent socket that is owned by init_user_ns *from* a
>> >    non-init_user_ns
>> >
>> > We account for 1. by only recording uevent sockets in the global uevent
>> > socket list who are owned by init_user_ns.
>> > But to account for 2. we need to filter by the user namespace who owns
>> > the socket in mc_list. So in addition to that we also need to slightly
>> > change the filter logic in kobj_bcast_filter() I think:
>> >
>> > diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
>> > index 22a2c1a98b8f..064d7d29ace5 100644
>> > --- a/lib/kobject_uevent.c
>> > +++ b/lib/kobject_uevent.c
>> > @@ -251,7 +251,8 @@ static int kobj_bcast_filter(struct sock *dsk, struct sk_buff *skb, void *data)
>> >  		return sock_ns != ns;
>> >  	}
>> >  
>> > -	return 0;
>> > + 	/* Check if socket was opened from non-initial user namespace. */
>> > + 	return sk_user_ns(dsk) != &init_user_ns;
>> >  }
>> >  #endif
>> >  
>> >
>> > But correct me if I'm wrong.
>> 
>> You are worrying about NETLINK_LISTEN_ALL_NSID sockets.  That has
>> permissions and an explicit opt-in to receiving packets from multiple
>> network namespaces.
>
> I don't think that's what I'm talking about unless that is somehow the
> default for NETLINK_KOBJECT_UEVENT sockets. What I'm worried about is
> doing
>
> unshare -U --map-root
>
> then opening a NETLINK_KOBJECT_UEVENT socket and starting to listen to
> uevents. Imho, this should not be possible because I'm in a
> non-init_user_ns. But currently I'm able to - even with the patch to
> come - since the uevent socket in the kernel was created when init_net
> was created and hence is *owned* by the init_user_ns which means it is
> in the list of uevent sockets. Here's a demo of what I mean:
>
> https://asciinema.org/a/175632

Why do you care about this case?

Everyone is allowed to listen to the uevent netlink sockets with or
without user namespaces.  So there are no permission issues, and
this is not even a data information leak.

If you don't want programs in your user namespace to have access you
will be able to unshare the network namespace.

Eric
