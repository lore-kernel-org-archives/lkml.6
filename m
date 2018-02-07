Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751786AbeBGWsZ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 17:48:25 -0500
Received: from mga12.intel.com ([192.55.52.136]:64825 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750745AbeBGWsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 17:48:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,473,1511856000";
   d="scan'208";a="172560436"
From: "Brown, Aaron F" <aaron.f.brown@intel.com>
To: "intel-wired-lan@lists.osuosl.or" <intel-wired-lan@lists.osuosl.or>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>
CC: Corentin Labbe <clabbe@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: Documentation: networking: ixgb: Remove reference to IXGB_NAPI
Thread-Topic: Re: Documentation: networking: ixgb: Remove reference to
 IXGB_NAPI
Thread-Index: AdOgZYAlEzRn1l0PQnS43K30EESNoA==
Date: Wed, 7 Feb 2018 22:48:21 +0000
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C7E2A92@ORSMSX103.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> Date: Mon, 29 Jan 2018 12:17:54 +0000
> From: Corentin Labbe <clabbe@baylibre.com>
> List-Id: Intel Wired Ethernet Linux Kernel Driver Development
>  <intel-wired-lan.osuosl.org>
> 
> NAPI is enabled by default and IXGB_NAPI was removed since
> commit 6d37ab282e24 ("ixgb: make NAPI the only option and the default")
> Update the doc accordingly.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  Documentation/networking/ixgb.txt | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
