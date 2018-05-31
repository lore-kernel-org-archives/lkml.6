Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751770AbeFALxV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 07:53:21 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:44262 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750850AbeFALxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 07:53:19 -0400
Date: Thu, 31 May 2018 10:24:37 -0400
From: Simon Horman <horms@verge.net.au>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: arm@kernel.org, biju.das@bp.renesas.com,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>, chris.redpath@arm.com,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 13/15] arm: dts: r8a77xx: Add missing OPP properties
 for CPUs
Message-ID: <20180531142433.ndnr7dn7nptkpb5k@verge.net.au>
References: <5821a6dbe413b5a217ca1e24ddf8ebfa63ba6ef0.1527244201.git.viresh.kumar@linaro.org>
 <c6254ebb1f177468db6b8ac560ffb5a4a0b864f0.1527655562.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6254ebb1f177468db6b8ac560ffb5a4a0b864f0.1527655562.git.viresh.kumar@linaro.org>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 10:16:58AM +0530, Viresh Kumar wrote:
> The OPP properties, like "operating-points", should either be present
> for all the CPUs of a cluster or none. If these are present only for a
> subset of CPUs of a cluster then things will start falling apart as soon
> as the CPUs are brought online in a different order. For example, this
> will happen because the operating system looks for such properties in
> the CPU node it is trying to bring up, so that it can create an OPP
> table.
> 
> Add such missing properties.
> 
> Fix other missing properties (like, clock latency, voltage tolerance,
> etc) as well to make it all work.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

This looks fine but I will wait to see if there are other reviews before
applying.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
