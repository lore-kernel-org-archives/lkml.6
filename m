Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751709AbeFDEQv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 00:16:51 -0400
Received: from mga17.intel.com ([192.55.52.151]:61758 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751444AbeFDEQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 00:16:48 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,475,1520924400";
   d="scan'208";a="60995469"
Date: Mon, 4 Jun 2018 06:16:47 +0200
From: Samuel Ortiz <sameo@linux.intel.com>
To: Colin King <colin.king@canonical.com>
Cc: linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfc: st21nfca: use setup_timer instead of init_timer
Message-ID: <20180604041647.GA8977@zurbaran.ger.intel.com>
References: <20171124133741.32371-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171124133741.32371-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

On Fri, Nov 24, 2017 at 01:37:41PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Use setup_timer function instead of initializing timer with the
> function and data fields.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/nfc/st21nfca/se.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
Applied to nfc-next, thanks.

Cheers,
Samuel.
