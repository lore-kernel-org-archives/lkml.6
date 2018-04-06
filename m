Return-Path: <ebiederm@xmission.com>
X-Google-Smtp-Source: AIpwx4/+9nS5r1cik8Ls7cd5rBcviKBFn38zyC0WHUm326IYinkzyu82KhSZBid4ZLKC8f0tIsRd
ARC-Seal: i=1; a=rsa-sha256; t=1523033393; cv=none;
        d=google.com; s=arc-20160816;
        b=jVaKdwOaPbZECM0eTe5QKmL3/20+fdqza+Eoo9h6clAx4NnZcAv8DrcK3mtZwbTwb/
         yXdFMMzB7RtnJZpCZTex78D3d73L1YHdTSSRdQr0jEI+SN86+4HSnevKbk3rrFYrhz2Q
         2uy4yH913yIH5CG507WRFaDQQkURjl06MoLcJbQbdeG8MRnUW9rRV0bNp8kYicll8IOH
         +WU3gTz1Dnulmidk361Qd8V9vQb8E4YcyKR2sl5j/2L0w0T1S5qNVxLCh5lFWXpck7bW
         SsbFFh9Vqow5X8ACauIM6lNPbYi4SPK7fvohcL12JUXPEC6vDjkTZGUZc4PdzVSbREXP
         wTjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:mime-version:user-agent:message-id:in-reply-to:date
         :references:cc:to:from:arc-authentication-results;
        bh=GXqw09iE2WZ6rnrZSQhBqwG9bvnySPnsVKmdiubPjbo=;
        b=uv9qf7lPQjE4mfk+8mY9hkjU06bZ2mWO/clgCEQufIv5v17sLDSSMDniaNJ7DGajqj
         VfzJX/MtDkGTQtCky7OWo/7cP29JedLnYIcdsauIlSFq2xROwxkulijvkdaaghxhSpku
         h0kzDZgnt4dtLFj/KcrgP+LId4L2KoE2WkGc00L0jy+zXtbR1OsUPNreSG6B3Xz9EmcM
         X0TB78kzAwbwBsEO3NlwAtdl/SrPQyo4c0I3AOtx4iN+BUgMuUmbedtauwNem16RqFso
         s4Cup6z8XbTVD9enqcPXuztgYTl1ghchy+UvlHjQrzm0MQ//1EOiYX136kM6FpwirX+r
         bICg==
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
	<20180405144130.GB26043@gmail.com> <87in953ryi.fsf@xmission.com>
	<20180406130704.GB9263@gmail.com> <874lko2y22.fsf@xmission.com>
	<20180406160757.GA16281@gmail.com>
Date: Fri, 06 Apr 2018 11:48:40 -0500
In-Reply-To: <20180406160757.GA16281@gmail.com> (Christian Brauner's message
	of "Fri, 6 Apr 2018 18:07:59 +0200")
Message-ID: <878ta01dsn.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f4UYg-0003es-NN;;;mid=<878ta01dsn.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.140.30;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18UpTC+KkMTUX3vAjek7BPquY8uFNX+Mq8=
X-SA-Exim-Connect-IP: 97.119.140.30
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4993]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christian Brauner <christian.brauner@canonical.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 169 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 2.5 (1.5%), b_tie_ro: 1.79 (1.1%), parse: 0.72 (0.4%),
	extract_message_metadata: 9 (5.6%), get_uri_detail_list: 0.98 (0.6%),
	tests_pri_-1000: 4.5 (2.7%), tests_pri_-950: 1.10 (0.7%), tests_pri_-900:
	0.92 (0.5%), tests_pri_-400: 17 (10.1%), check_bayes: 16 (9.6%), b_tokenize:
	5 (3.1%), b_tok_get_all: 5 (3.2%), b_comp_prob: 1.58 (0.9%), b_tok_touch_all:
	2.2 (1.3%), b_finish: 0.58 (0.3%), tests_pri_0: 126 (74.8%),
	check_dkim_signature: 0.44 (0.3%), check_dkim_adsp: 2.5 (1.5%),
	tests_pri_500: 3.6 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH net-next] netns: filter uevents correctly
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596846368169451603?=
X-GMAIL-MSGID: =?utf-8?q?1597016262742739652?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Christian Brauner <christian.brauner@canonical.com> writes:

>> At a practical level there should be no receivers.  Plus performance
>> issues.  At least my memory is that any unprivileged user on the system
>> is allowed to listen to those events.
>
> Any unprivileged user is allowed to listen to uevents if they have
> net_broadcast in the user namespace the uevent socket was opened in;
> unless I'm misreading.

I believe you are.

This code in do_one_broadcast.

	if (!net_eq(sock_net(sk), p->net)) {
		if (!(nlk->flags & NETLINK_F_LISTEN_ALL_NSID))
			return;

		if (!peernet_has_id(sock_net(sk), p->net))
			return;

		if (!file_ns_capable(sk->sk_socket->file, p->net->user_ns,
				     CAP_NET_BROADCAST))
			return;
	}

Used to just be:
	if (!net_eq(sock_net(sk), p->net))
        	return;

Which makes sense when you have a shared hash table and a shared mc_list
between network namespaces.

There is a non-container use of network namespaces where you just need
different contexts were ip addresses can overlap etc.  In that
configuration where a single program is mananging multiple network
namespaces being able to listen to rtnetlink events in all of them is an
advantage.

For that case a special socket option NETLINK_F_LISTEN_ALL_NSID was
added that allowed one socket to listen for events from multiple network
namespaces.

If we rework the code in af_netlink.c that matters.  However for just
understanding uevents you can assume there are no sockets with
NETLINK_F_LISTEN_ALL_NSID set.

Eric
