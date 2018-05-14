Return-Path: <fengguang.wu@intel.com>
X-Google-Smtp-Source: AB8JxZrJTdThqBYue2lxY79BICaeH4es47RBd3EcCEI/3EiKAwfSSYLbNMHVnZ9Q1wXryS5ch2UA
ARC-Seal: i=1; a=rsa-sha256; t=1526289952; cv=none;
        d=google.com; s=arc-20160816;
        b=T6IzuaByxZ9nDB2JW930bZKR8KC5D+c3b91N/VShjF3eh9F2jKpfDCuk2Ryl9Ek810
         xXsXU3m3VSNta7xfuAWEluMVQ/7I6tr77lJNZm8q0J6RMwUc8TbuIEP2h+dV87A6+iJv
         WTCjiyopwpDcCGHtxBlbiGz/46KODg+CPviXz0MihMJndXF/c7rBqJ+M65E/fJEiWASl
         TCdyT9y1+szJDUrsRiLPCeZzQ/Q9URu6rfiL8U4J6AlxjbvkzjFv9n8MLQyK2wkIB34k
         DrdqkkqpXWEkv6QcbDLAu9KqN6LkilIZO9zqnfZL4yyTw44CKo8XGUZzt991VdiZ+ZOG
         +TPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=s/5H4oABHhLBpZ/YnXky5aFkK4pp0Hne7LQeOXA3Tyo=;
        b=n11mRKtRPzPFeNidauZCQ5jZDl+NzN+cXq/k5KvosnE8sAZ8TcXjRbd/Vdn25xws0e
         Gs641buKi4v41xNotM74ZMbzQcSJc53xecKVeQ7ePx2gnel+FBcuMwXPLoXuhqkUsCbD
         92j+rwG0Tx8QGFkTrWVcGsNDepf9NATOk+roNN4fg86jxGe+Uu+tm+RPP2e5HxdXJ5nE
         xFa6Sj7EsVkq1Hpgfb3GjfpQQAEJPHN2G+tf23Ta3X1p1z+s0C5NjCi1BNvh6Fh+AeNM
         ijlocg2imeYg2hg14C/hyVO60e3Fmh5guotvjU/J1AQGDecOzGCCX529c5WZM4rWA+iT
         r/2w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,399,1520924400";
   d="scan'208";a="49036350"
Date: Mon, 14 May 2018 17:25:48 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Sasha Levin <Alexander.Levin@microsoft.com>,
	"ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"w@1wt.eu" <w@1wt.eu>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180514092548.qwv4ycsixduqd6q3@wfg-t540p.sh.intel.com>
References: <CAKMK7uEWYmhA3owSeYM9tNA0tpMm5=4Yqda2j=VfMWi7i8ya8w@mail.gmail.com>
 <nycvar.YFH.7.76.1805101802150.27054@cbobk.fhfr.pm>
 <20180510164722.GH8514@sasha-vm>
 <CAMuHMdWDNjsba29id4Svjy_tauKivWDUixub3qf82Nx_6rYueA@mail.gmail.com>
 <CAMuHMdUHK=kmJB-=G-Y7YEneZityMzi5YZ3nJFD6uCs61bOaiQ@mail.gmail.com>
 <20180514101237.5df1e0d7@bbrezillon>
 <CAMuHMdWQTOioXPmWX+_jetECpp9=SCK_BfWq9kJ7xj3WTnB_ng@mail.gmail.com>
 <20180514103428.55285a70@bbrezillon>
 <CAMuHMdVwA6jK1fPu3Dzc4-+_kWv1yTNvOGJP811Fdyrrnbc18w@mail.gmail.com>
 <20180514104803.23d2a8a3@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180514104803.23d2a8a3@bbrezillon>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1600003109861123526?=
X-GMAIL-MSGID: =?utf-8?q?1600431013090744628?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 10:48:03AM +0200, Boris Brezillon wrote:
>+Fengguang
>
>On Mon, 14 May 2018 10:40:10 +0200
>Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
>> Hi Boris,
>>
>> On Mon, May 14, 2018 at 10:34 AM, Boris Brezillon
>> <boris.brezillon@bootlin.com> wrote:
>> > On Mon, 14 May 2018 10:29:04 +0200
>> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> >> On Mon, May 14, 2018 at 10:12 AM, Boris Brezillon
>> >> <boris.brezillon@bootlin.com> wrote:
>> >> > On Mon, 14 May 2018 10:00:30 +0200
>> >> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> >> >> On Tue, May 1, 2018 at 10:00 PM, Sasha Levin
>> >> >> <Alexander.Levin@microsoft.com> wrote:
>> >> >> > On Tue, May 01, 2018 at 03:44:50PM -0400, Theodore Y. Ts'o wrote:
>> >> >> >>On Tue, May 01, 2018 at 04:38:21PM +0000, Sasha Levin wrote:
>> >> >> > What's worse is that that commit is tagged for stable, which means
>> >> >> > that (given Greg's schedule) it may find it's way to -stable users
>> >> >> > even before some -next users/bots had a chance to test it out.
>> >> >>
>> >> >> I just noticed a case where a commit was picked up for stable, while a
>> >> >> bot had flagged it as a build regression 18 hours earlier (with a CC to
>> >> >> lkml).
>> >> >
>> >> > Also, this patch has been on a tree that I know is tested by Fengguang's
>> >> > robots for more than a week (and in linux-next for 2 days, which, I
>> >> > agree, is probably not enough), and still, I only received the bug
>> >> > report when the patch reached mainline. Are there tests that are only
>> >> > run on Linus' tree?
>> >>
>> >> Have your received a success report from Fengguang's bot, listing all
>> >> configs tested (the broken one should be included; it is included in the
>> >> configs tested on my branches)?
>> >
>> > Yes I did (see below).
>> >
>> > -->8--
>> > From: kbuild test robot <lkp@intel.com>
>> > To: Boris Brezillon <boris.brezillon@bootlin.com>
>> > Subject: [bbrezillon-0day:mtd/fixes] BUILD SUCCESS  fc3a9e15b492eef707afd56b7478001fdecfe53f
>> > Date: Mon, 07 May 2018 20:05:52 +0800
>> > User-Agent: Heirloom mailx 12.5 6/20/10
>> >
>> > tree/branch: https://github.com/bbrezillon/linux-0day  mtd/fixes
>> > branch HEAD: fc3a9e15b492eef707afd56b7478001fdecfe53f  mtd: rawnand: Make sure we wait tWB before polling the STATUS reg
>> >
>> > elapsed time: 49m
>> >
>> > configs tested: 142
>>
>> But the failed config (m68k/allmodconfig) is not listed?
>
>Yes, that's my point. It seems that some configs are only rarely
>(never?) tested on my linux-0day tree (probably because they take longer
>to build), and I should only take kbuild robot results as an indication
>not a guarantee.

Yeah sorry, there is no 100% guarantee. There are 2 main aspects to
this problem.

- Response time vs coverage. Most build errors can be caught within 1
  day. The build success notification email is typically sent within
  half day (a reasonable feedback time). At this time, it can only be
  a rough indication not a guarantee. After sending the 0day build
  success notification, the build tests will actually continue for
  about 1 week to increase test coverage. 

- Merge-test-bisect based workflow. If one branch is hard to merge
  with others, especially if it's based on old kernel, it'll receive
  much less test coverage. Branches with known build/boot errors will
  be excluded from further merges, too.

Thanks,
Fengguang
