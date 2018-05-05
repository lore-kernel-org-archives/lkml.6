Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-1214736-1525496589-2-15604437918950005031
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_HELO_PASS -0.001, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.169.12', Host='mail.linuxfoundation.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ksummit-discuss-bounces@lists.linuxfoundation.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525496588; b=OwsVgjf0rFAOPE9a9LXNF3p2Gj17o7h3y72MQr4xF7RNyHYPZt
    0t0MDjhMphRTb2MWa/cKpt1Pzo8lngTCxGMY8shmxcjLAcDf6wIAstWM3gdrwz5N
    PJ58tmmuXaGd4wXCQhKN9gQh+Tc7ourPs2kcsAMMC0xW/uEs0MU9pFgvlA0SqOv5
    vFVDp0HeIC85wQEGnz1rnI5w3NZKC1I9iNL80xYxXhPqa2eIMPARWuOy4WMvCqRx
    UZN7IbRMargdJ14pzwZ8runW88mNmRNzjgkkZj6P6QjO8bwmItPMUjIdj4LyZhFy
    8Hu+nGUu8G0xKEIE9c3DjXfOsHQ4X/CoMOQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:references:date:in-reply-to
    :message-id:mime-version:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525496588; bh=aaBOF
    S0UzcWn1drdMud8E8j8SNUv+JVMI1PzxAnCk8Q=; b=Shd/KC9xu9NshN8EK05nT
    +1ibR+JAoeqVDzQk4djycJemRcvV6bn7DSn1kRJpf0NAJXBs887cXC1bIoWVziMA
    9sRZX43eZEYASjPWjHE/NAi5GV7O/4scDS8fBqq0HarcWxv+FsHB3BWS3PF1czJq
    Oi6/qG4LCR32NkvDEgh3hg0RrhTW7Bk2Mq5gWf8haEzOmDPdyoKYRFR2MQUWTxGW
    iceIGVaFr3A3PjzQBZibSneUat+vk2t1UH/22Z9T5jsTfvo+MOsxhQ0E0l/Gq5zJ
    B4ewAdnfmeCk3W7TF5IrsFkoaW5XhJTNHy9LQDBI+tr1tvK1buGCQU9jD75QZUYi
    w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
    smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
    x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
    smtp_org.domain=linuxfoundation.org smtp_org.result=pass
    smtp_is_org_domain=no header.domain=xmission.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
      smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
      x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
      smtp_org.domain=linuxfoundation.org smtp_org.result=pass
      smtp_is_org_domain=no header.domain=xmission.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMz309JxTCYFyO6TFZWm75Io09SIUnKBEQiooszj9nrwAtu7btfCujKHna9sph1y0+FuGjxyTTxiccPs9ovmIYO9YLiD7F29Si8Q153UCVgn3kwdAviA
    v4zXGLwpEvTxT/TpTlS9P+Q+vTwIyCH034E61sWTSJgQStJ47oD2CoHcz1C1O+WAOclpEeD0ICIl2FVw8YhQbHj3YGJgGdKXdyuKYHwjWjcDrMqbSnKMC6Z7
    3PQpZUKcX+HbYK2ih3kozA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=MYakio4dAAAA:8 a=VwQbUJbxAAAA:8
    a=ag1SF4gXAAAA:8 a=dw9PmonOgE2zrDRAgt0A:9 a=CjuIK1q_8ugA:10
    a=cei-m1nUyINrUup_78-m:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
From: ebiederm@xmission.com (Eric W. Biederman)
To: Willy Tarreau <w@1wt.eu>
References: <20180503173422.GR18390@sasha-vm>
	<20180503182039.GC30522@ZenIV.linux.org.uk>
	<8669.1525427874@warthog.procyon.org.uk> <87fu377gbu.fsf@intel.com>
	<20180504130932.GI29205@thunk.org> <20180504174055.GF4649@kroah.com>
	<20180504211317.GK29205@thunk.org>
	<1525469881.4114.5.camel@HansenPartnership.com>
	<20180504215111.GX18390@sasha-vm> <20180504233542.GM29205@thunk.org>
	<20180505042356.GA24575@1wt.eu>
Date: Sat, 05 May 2018 00:02:47 -0500
In-Reply-To: <20180505042356.GA24575@1wt.eu> (Willy Tarreau's message of "Sat,
	5 May 2018 06:23:56 +0200")
Message-ID: <878t8y8zk8.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1fEpLT-0005JS-E6; ; ; mid=<878t8y8zk8.fsf@xmission.com>; ; ;
	hst=in01.mta.xmission.com; ; ; ip=97.119.174.25; ; ;
	frm=ebiederm@xmission.com; ; ; spf=neutral
X-XM-AID: U2FsdGVkX182a3ztrlMc6yEr1/JDsrLGVWYMwdL8Y5o=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW
	autolearn=ham version=3.3.1
X-Remote-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ;Willy Tarreau <w@1wt.eu>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 1797 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 7 (0.4%), b_tie_ro: 5 (0.3%), parse: 1.32 (0.1%),
	extract_message_metadata: 28 (1.6%), get_uri_detail_list: 5 (0.3%),
	tests_pri_-1000: 8 (0.5%), tests_pri_-950: 2.1 (0.1%),
	tests_pri_-900: 1.72
	(0.1%), tests_pri_-400: 45 (2.5%), check_bayes: 43 (2.4%),
	b_tokenize: 16
	(0.9%), b_tok_get_all: 12 (0.6%), b_comp_prob: 7 (0.4%),
	b_tok_touch_all: 3.0
	(0.2%), b_finish: 0.83 (0.0%), tests_pri_0: 1689 (94.0%),
	check_dkim_signature: 0.91 (0.1%), check_dkim_adsp: 4.4 (0.2%),
	tests_pri_500: 9 (0.5%), poll_dns_idle: 0.14 (0.0%),
	rewrite_mail: 0.00 (0.0%)
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
	"ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
X-BeenThere: ksummit-discuss@lists.linuxfoundation.org
X-Mailman-Version: 2.1.12
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/ksummit-discuss>,
	<mailto:ksummit-discuss-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/ksummit-discuss/>
List-Post: <mailto:ksummit-discuss@lists.linuxfoundation.org>
List-Help: <mailto:ksummit-discuss-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss>,
	<mailto:ksummit-discuss-request@lists.linuxfoundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: ksummit-discuss-bounces@lists.linuxfoundation.org
Errors-To: ksummit-discuss-bounces@lists.linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Willy Tarreau <w@1wt.eu> writes:

> On Fri, May 04, 2018 at 07:35:42PM -0400, Theodore Y. Ts'o wrote:
>> On Fri, May 04, 2018 at 09:51:14PM +0000, Sasha Levin wrote:
>> > I don't have an objection to moving this to it's own tag. It will make
>> > my scripts somewhat simpler for sure.
>> 
>> It's not a matter "moving this it's own tag", but creating a new tag
>> --- because what is in the docs is a lie.  It does not describe what
>> we do today.  And current practice is the reality, not what is in the
>> docs.
>> 
>> As to whether we should create a new tag to support explicit
>> dependencies, I'll leave that between you and Greg K-H and the rest of
>> the stable maintainers.  :-)
>
> Guys, *personally*, I've sometimes been a bit annoyed by the huge amount
> of irregular extra headers trying to compensate for horribly vague commit
> messages, and I'm pretty sure it pisses off patch authors who don't know
> anymore what to put in their description. We need to keep in mind that
> authors are humans and not machines, and that natural language remains
> the best to explain complex dependencies. I'd prefer to see :
>
>     This patch needs to be backported to all stable branches that contain
>     717d3133 and 207f5b3c (that's 3.10+) or their respective backports but
>     must be adapted (contact me) if only a backport of 717d3133 is present.
>
>     Cc: stable # v3.10+
>
> Rather than horrible stuff like this :
>
>     Cc: stable # v3.10+ (717d3133 && 207f5b3c) || WARN_ON(back(717d3133))
>
> Of course it's a bit made up, but not too far from what is being discussed
> here, probably only the next step. People will often get complex rules
> wrong, both on the producer and on the consumer side. The day we need a
> compiler to emit commit messages, we'll have to wonder if we didn't go
> too far.
>
> Also I've found the Fixes header pretty useful. It allows patch authors
> to mention what is being fixed without necessarily copying stable,
> because sometimes you'd rather not see your patch immediately backported
> or you think the risks are higher than the bug. And here as well, it's
> only suited for simple situations with a single commit ID, complex
> desriptions have to be part of the commit message body.
>
> I think that what we have now works pretty well but that some descriptions
> lack a bit of detail, especially on the impact of the bug which would help
> decide to backport or drop. This is understandable because often the person
> fixing a bug documents it for people knowing the same subsystem well. But
> when you backport fixes into other kernel versions, you don't know well
> how each subsystem works, and guessing the impact of a bug is not always
> obvious. Most of the time, authors who add Fixes: and/or Cc: stable take
> care of providing enough information, though I'd suspect that sometimes
> they're making efforts trying to figure how to place the information
> there and possibly try to avoid redundancy by writing a shorter body.
>
> At this point, I'm really not seeing what we're trying to improve or
> optimize, and to be honest this discussion worries me a bit, by just
> thinking that it could result in annoying changes...

So the way I use headers today is:
Cc: stable@vger.kernel.org
Fixes: sha1hash "commit subject"

I will use "Fixes: v2.0.1" if something is so old that it isn't in git.
If it was in bitkeeper and now in tglx's tree I will use:
History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git

Just because you won't find the commit in Linus's git tree.

I tend not to find particularly serious bugs, just ancient ones so I
generally figure if it doesn't backport easily it probably is not a
candidate for stable.  The bug has existed for ages without anyone
really carring anyway.

Eric
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
