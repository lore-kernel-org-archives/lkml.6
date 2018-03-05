Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752646AbeCESJu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 13:09:50 -0500
Received: from mga11.intel.com ([192.55.52.93]:11583 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751852AbeCESJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 13:09:48 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,427,1515484800";
   d="scan'208";a="25357852"
Date: Mon, 5 Mar 2018 20:09:44 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tpm: tpm-interface: fix tpm_transmit/_cmd  kdoc
Message-ID: <20180305180944.GC6220@linux.intel.com>
References: <20180305124826.5160-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305124826.5160-1-tomas.winkler@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 02:48:25PM +0200, Tomas Winkler wrote:
> Fix tmp_ -> tpm_ typo and add reference to 'space' parameter
> in kdoc for tpm_transmit and tpm_transmit_cmd functions.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
>  drivers/char/tpm/tpm-interface.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 64dbec078c1b..cafec634181a 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -399,9 +399,10 @@ static void tpm_relinquish_locality(struct tpm_chip *chip)
>  }
>  
>  /**
> - * tmp_transmit - Internal kernel interface to transmit TPM commands.
> + * tpm_transmit - Internal kernel interface to transmit TPM commands.
>   *
>   * @chip: TPM chip to use
> + * @space: tpm space
>   * @buf: TPM command buffer
>   * @bufsiz: length of the TPM command buffer
>   * @flags: tpm transmit flags - bitmap
> @@ -549,10 +550,11 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
>  }
>  
>  /**
> - * tmp_transmit_cmd - send a tpm command to the device
> + * tpm_transmit_cmd - send a tpm command to the device
>   *    The function extracts tpm out header return code
>   *
>   * @chip: TPM chip to use
> + * @space: tpm space
>   * @buf: TPM command buffer
>   * @bufsiz: length of the buffer
>   * @min_rsp_body_length: minimum expected length of response body
> -- 
> 2.14.3
> 

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
