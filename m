Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752442AbeBIS7z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 13:59:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:52896 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752089AbeBIS7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 13:59:54 -0500
Subject: Re: [GIT PULL] xen: fixes for 4.16 rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <20180209142800.25485-1-jgross@suse.com>
 <CA+55aFxyEpQUgpZtkRbc1ESbMBw6FcbLgbzB3ioPN_097HpzOg@mail.gmail.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <86b2120d-bf1b-16ba-0341-8e629425b799@suse.com>
Date: Fri, 9 Feb 2018 19:59:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CA+55aFxyEpQUgpZtkRbc1ESbMBw6FcbLgbzB3ioPN_097HpzOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/18 19:48, Linus Torvalds wrote:
> On Fri, Feb 9, 2018 at 6:28 AM, Juergen Gross <jgross@suse.com> wrote:
>>
>>  git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-4.16-rc1-tag
> 
> So I've pulled this, but the back-merges *really* annoy me.
> 
> Seriously, DON'T DO MERGES IF YOU CANNOT EVEN BE BOTHERED TO WRITE A
> REASON FOR THEM!

Sorry, I managed to screw my git tree up.

I'll modify my scripts to avoid this kind of mess.

Do you want me to setup the patches for pulling again?


Juergen
