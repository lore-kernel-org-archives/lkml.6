Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751640AbeEQFYg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 01:24:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:7993 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750779AbeEQFYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 01:24:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,409,1520924400";
   d="scan'208";a="200064330"
Message-ID: <4d7158c407973a5be972a690a64c3f69119bd921.camel@intel.com>
Subject: Re: [linux-firmware] Version in WHENCE file
From: Luciano Coelho <luciano.coelho@intel.com>
To: sedat.dilek@gmail.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 17 May 2018 08:24:31 +0300
In-Reply-To: <CA+icZUXy5VyJq_L=ipyutvYk6gpsCb9jxHzBa7T3MRhs3XgQKA@mail.gmail.com>
References: <CA+icZUXrHmOJPKT0gnym9yOs6Erm3wDOZU3sbr_MGB8pYjfuzA@mail.gmail.com>
         <0f8aaff5ecad8af6d146453d4d3a5d4dd145977b.camel@intel.com>
         <CA+icZUXy5VyJq_L=ipyutvYk6gpsCb9jxHzBa7T3MRhs3XgQKA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-07 at 09:47 +0200, Sedat Dilek wrote:
> On Sun, May 6, 2018 at 3:07 PM, Luciano Coelho <luciano.coelho@intel.
> com> wrote:
> > On Sun, 2018-05-06 at 14:46 +0200, Sedat Dilek wrote:
> > > Hi Luca,
> > > 
> > > I hope I catched the correct MLs (not sure if linux-firmware has
> > > a
> > > ML,
> > > I did not found any in the MAINTAINERS file).
> > > 
> > > I have seen that in the WHENCE file there is "Version" with and
> > > without ":", mostly iwlwifi ucodes.
> > > 
> > > As an example:
> > > 
> > >  File: iwlwifi-8265-36.ucode
> > > -Version 36.e91976c0.0
> > > +Version: 36.e91976c0.0
> > > 
> > > I don't know the workflow: Do you want to fix it in your tree or
> > > directly in linux-firmware.git upstream?
> > > My attached patch is against upstream.
> > 
> > Thanks, Sedat!
> > 
> > I'm going to send a new pull-request this week, so I can include
> > your
> > patch in my tree and as part of the pull-request.
> > 
> > --
> > Cheers,
> > Luca.
> 
> OK, Thanks.
> Attached Patch v2 is against your tree [1].
> It differs from v1 against upstream.

You need to write a proper commit message and sign it off so I can
apply it.

--
Luca.
