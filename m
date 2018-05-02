Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbeEBWZ3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 18:25:29 -0400
Received: from imap.thunk.org ([74.207.234.97]:55634 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751148AbeEBWZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 18:25:27 -0400
Date: Wed, 2 May 2018 18:25:22 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Laura Abbott <labbott@redhat.com>
Cc: Justin Forbes <jmforbes@linuxtx.org>, Jeremy Cline <jeremy@jcline.org>,
        Sultan Alsawaf <sultanxda@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180502222522.GA15457@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Laura Abbott <labbott@redhat.com>,
        Justin Forbes <jmforbes@linuxtx.org>,
        Jeremy Cline <jeremy@jcline.org>,
        Sultan Alsawaf <sultanxda@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20180429202033.ysmc42mj2rrk3h7p@sultan-box>
 <20180429220519.GQ5965@thunk.org>
 <01000163186628e6-3fe4abfc-eaaf-470c-90c8-2d8ad91db8f1-000000@email.amazonses.com>
 <CAFxkdAogN0S9vgQhKoO+Zpp07bXveDQYPLvwjULoTRv3Or83qQ@mail.gmail.com>
 <20180501125518.GI20585@thunk.org>
 <CAFxkdArLwrG8x6fNtLUfHedKrH_0d97V6UEzOCBgK8Shkir9pQ@mail.gmail.com>
 <20180502000250.GI10479@thunk.org>
 <CAFxkdAp83uWnju0KZKd2edveuzmiDW_sqMORC7uoR+pwgQECNw@mail.gmail.com>
 <20180502162653.GB3461@thunk.org>
 <3851ac8b-357d-3c82-2195-936e3c459212@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3851ac8b-357d-3c82-2195-936e3c459212@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 10:49:34AM -0700, Laura Abbott wrote:
> 
> It is a Fedora patch we're carrying
> https://src.fedoraproject.org/rpms/libgcrypt/blob/master/f/libgcrypt-1.6.2-fips-ctor.patch#_23
> so yes, it is a Fedora specific use case.
> From talking to the libgcrypt team, this is a FIPS mode requirement
> to run power on self test at the library constructor and the self
> test of libgrcypt ends up requiring a fully seeded RNG. Citation
> is in section 9.10 of
> https://csrc.nist.gov/CSRC/media/Projects/Cryptographic-Module-Validation-Program/documents/fips140-2/FIPS1402IG.pdf

Forgive me if this is a stupid question, but does Fedora need FIPS
compliance?  Or is this something which is only required for RHEL?

("Here's to FIPS: the cause of, and solution to, all of Life's
problems."  :-)

	  	   		     - Ted
