Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755996AbeEAPFP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 11:05:15 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:37618 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753072AbeEAPFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 11:05:13 -0400
X-Google-Smtp-Source: AB8JxZq76RtZblv59l53l0bj56hfMktbKtzgwXAyJB/KlHhputwHy5EU1zVHd2hLt75vqxW9m80iVg==
Date: Tue, 1 May 2018 10:05:12 -0500
From: Rob Herring <robh@kernel.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, davem@davemloft.net, mark.rutland@arm.com
Subject: Re: [RFC/PATCH] net: ethernet: nixge: Use of_get_mac_address()
Message-ID: <20180501150512.GA21443@rob-hp-laptop>
References: <20180426215742.18966-1-mdf@kernel.org>
 <20180426220401.bad53hxnkxwvgjot@derp-derp.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426220401.bad53hxnkxwvgjot@derp-derp.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 03:04:01PM -0700, Moritz Fischer wrote:
> On Thu, Apr 26, 2018 at 02:57:42PM -0700, Moritz Fischer wrote:
> > Make nixge driver work with 'mac-address' property instead of
> > 'address' property. There are currently no in-tree users and
> > the only users of this driver are devices that use overlays
> > we control to instantiate the device together with the corresponding
> > FPGA images.
> > 
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > ---
> > 
> > Hi David, Rob,
> > 
> > with Mike's change that enable the generic 'mac-address'
> > binding that I barely missed with the submission of this
> > driver I was wondering if we can still change the binding.
> > 
> > I'm aware that this generally is a nonono case, since the binding
> > is considered API, but since there are no users outside of our
> > devicetree overlays that we ship with our devices I thought I'd ask.

Fine by me. It really comes down to whether there are any users that 
would be impacted.

Rob
