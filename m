Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165769AbeE1O3P (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:29:15 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34234 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161775AbeE1O3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 10:29:10 -0400
X-Google-Smtp-Source: AB8JxZrAvkUm1OuASk5sDeoYLBK9XSRtPYmcGWRbcfpbyDL9bxNMYCdkZB+eMpqcRph3LJqrLEYZpw==
Date: Mon, 28 May 2018 07:29:07 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Yangbo Lu <yangbo.lu@nxp.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, claudiu.manoil@nxp.com,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/5] ptp: rework gianfar_ptp as QorIQ common PTP driver
Message-ID: <20180528142907.t5m6j2xh5ecfmtgn@localhost>
References: <20180525044038.37756-1-yangbo.lu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525044038.37756-1-yangbo.lu@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 12:40:34PM +0800, Yangbo Lu wrote:
> gianfar_ptp was the PTP clock driver for 1588 timer
> module of Freescale QorIQ eTSEC (Enhanced Three-Speed
> Ethernet Controllers) platforms. Actually QorIQ DPAA
> (Data Path Acceleration Architecture) platforms is
> also using the same 1588 timer module in hardware.
> 
> This patch is to rework gianfar_ptp as QorIQ common
> PTP driver to support both DPAA and eTSEC. Moved
> gianfar_ptp.c to drivers/ptp/, renamed it as
> ptp_qoriq.c, and renamed many variables. There were
> not any function changes.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

For the series:

Acked-by: Richard Cochran <richardcochran@gmail.com>
