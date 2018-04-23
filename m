Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932314AbeDWSxa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 14:53:30 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34899 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932085AbeDWSx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 14:53:29 -0400
X-Google-Smtp-Source: AIpwx48lpmJePFWOYAksFgt20wFnKJ3OX3IdZiviw0oIxP5e0Jr3OfbM0XC8DMEJtYvi44KelLlUHA==
Date: Mon, 23 Apr 2018 11:53:25 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        lyan@suse.com, boris.ostrovsky@oracle.com, andrii_chepurnyi@epam.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: Re: [PATCH] Input: xen-kbdfront - allow better run-time configuration
Message-ID: <20180423185325.GB66646@dtor-ws>
References: <20180418150445.9805-1-andr2000@gmail.com>
 <ccb7a33b-7862-9803-fb24-67861d5ecab9@suse.com>
 <2bff035e-303e-d644-5f51-5e64150c097c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bff035e-303e-d644-5f51-5e64150c097c@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 02:44:19PM +0300, Oleksandr Andrushchenko wrote:
> On 04/19/2018 02:25 PM, Juergen Gross wrote:
> > On 18/04/18 17:04, Oleksandr Andrushchenko wrote:
> > > From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> > > 
> > > It is now only possible to control if multi-touch virtual device
> > > is created or not (via the corresponding XenStore entries),
> > > but keyboard and pointer devices are always created.
> > Why don't you want to go that route for keyboard and mouse, too?
> > Or does this really make no sense?
> Well, I would prefer not to touch anything outside Linux and
> this driver. And these settings seem to be implementation specific.
> So, this is why introduce Linux module parameters and don't extend
> the kbdif protocol.

Why do you consider this implementation specific? How other guests
decide to forego creation of relative pointer device or keyboard-like
device?

You already have "features" for absolute pointing device and multitouch,
so please extend the protocol properly so you indeed do not code
something implementation-specific (i.e. module parameters).

Thanks.

-- 
Dmitry
