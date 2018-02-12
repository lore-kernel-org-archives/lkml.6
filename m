Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754265AbeBLOmt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 09:42:49 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:43111 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754244AbeBLOmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 09:42:45 -0500
X-Google-Smtp-Source: AH8x227cgIylQl2pKi1NxBqLa/KaLcE5b3TS7KcWxwrFfA2X76GRcJmBVasrla6n3bLsI4cEDwbmbQ==
Date: Mon, 12 Feb 2018 08:42:43 -0600
From: Rob Herring <robh@kernel.org>
To: Mikko Perttunen <cyndis@kapsi.fi>
Cc: Mikko Perttunen <mperttunen@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, mark.rutland@arm.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/7] dt-bindings: tegra: Add missing chips and NVIDIA
 boards
Message-ID: <20180212144243.5ovljzk2heu3ccck@rob-hp-laptop>
References: <1517901757-15353-1-git-send-email-mperttunen@nvidia.com>
 <1517901757-15353-5-git-send-email-mperttunen@nvidia.com>
 <20180209224922.4fxlpl77kwibzfui@rob-hp-laptop>
 <5105d996-8020-ebcf-cf46-2f13c6b8b35f@kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5105d996-8020-ebcf-cf46-2f13c6b8b35f@kapsi.fi>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 10, 2018 at 10:45:35AM +0200, Mikko Perttunen wrote:
> On 02/10/2018 12:49 AM, Rob Herring wrote:
> > On Tue, Feb 06, 2018 at 09:22:34AM +0200, Mikko Perttunen wrote:
> > > Add compatibility strings for supported but undocumented Tegra chips
> > > (Tegra114/124/132/210/186/194) and reference boards.
> > > 
> > > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > > ---
> > > 
> > > Notes:
> > >      v2:
> > >      - add patch
> > > 
> > >   Documentation/devicetree/bindings/arm/tegra.txt | 16 ++++++++++++++++
> > >   1 file changed, 16 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/arm/tegra.txt b/Documentation/devicetree/bindings/arm/tegra.txt
> > > index 7f1411bbabf7..32f62bb7006d 100644
> > > --- a/Documentation/devicetree/bindings/arm/tegra.txt
> > > +++ b/Documentation/devicetree/bindings/arm/tegra.txt
> > > @@ -9,6 +9,12 @@ following compatible values:
> > >     nvidia,tegra20
> > >     nvidia,tegra30
> > > +  nvidia,tegra114
> > > +  nvidia,tegra124
> > > +  nvidia,tegra132
> > > +  nvidia,tegra210
> > 
> > Some reason why this is not in numerical order?
> 
> They are in chronological/chip generation order, and for whatever reason,
> that isn't numerical.

Okay.

Reviewed-by: Rob Herring <robh@kernel.org>
