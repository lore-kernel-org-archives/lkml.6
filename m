Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751389AbeCLLQs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 07:16:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52830 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751104AbeCLLQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 07:16:47 -0400
Date: Mon, 12 Mar 2018 11:16:32 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, dave.martin@arm.com, catalin.marinas@arm.com
Subject: Re: [PATCH v3 1/2] arm64: Documentation: cpu-feature-registers:
 Remove RES0 fields
Message-ID: <20180312111631.6r7nofsazhha6lo7@lakrids.cambridge.arm.com>
References: <20180312100414.6809-1-suzuki.poulose@arm.com>
 <20180312100414.6809-2-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312100414.6809-2-suzuki.poulose@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 10:04:13AM +0000, Suzuki K Poulose wrote:
> Remove the invisible RES0 field entries from the table, listing
> fields in CPU ID feature registers, as :
>  1) We are only interested in the user visible fields.
>  2) The field description may not be up-to-date, as the
>     field could be assigned a new meaning.
>  3) We already explain the rules of the fields which are not
>     visible.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Dave Martin <dave.martin@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Sounds reasonable to me. FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  Documentation/arm64/cpu-feature-registers.txt | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/Documentation/arm64/cpu-feature-registers.txt b/Documentation/arm64/cpu-feature-registers.txt
> index a70090b28b07..22cfb86143ee 100644
> --- a/Documentation/arm64/cpu-feature-registers.txt
> +++ b/Documentation/arm64/cpu-feature-registers.txt
> @@ -110,7 +110,6 @@ infrastructure:
>       x--------------------------------------------------x
>       | Name                         |  bits   | visible |
>       |--------------------------------------------------|
> -     | RES0                         | [63-52] |    n    |
>       |--------------------------------------------------|
>       | FHM                          | [51-48] |    y    |
>       |--------------------------------------------------|
> @@ -124,8 +123,6 @@ infrastructure:
>       |--------------------------------------------------|
>       | RDM                          | [31-28] |    y    |
>       |--------------------------------------------------|
> -     | RES0                         | [27-24] |    n    |
> -     |--------------------------------------------------|
>       | ATOMICS                      | [23-20] |    y    |
>       |--------------------------------------------------|
>       | CRC32                        | [19-16] |    y    |
> @@ -135,8 +132,6 @@ infrastructure:
>       | SHA1                         | [11-8]  |    y    |
>       |--------------------------------------------------|
>       | AES                          | [7-4]   |    y    |
> -     |--------------------------------------------------|
> -     | RES0                         | [3-0]   |    n    |
>       x--------------------------------------------------x
>  
>  
> @@ -144,12 +139,9 @@ infrastructure:
>       x--------------------------------------------------x
>       | Name                         |  bits   | visible |
>       |--------------------------------------------------|
> -     | RES0                         | [63-36] |    n    |
>       |--------------------------------------------------|
>       | SVE                          | [35-32] |    y    |
>       |--------------------------------------------------|
> -     | RES0                         | [31-28] |    n    |
> -     |--------------------------------------------------|
>       | GIC                          | [27-24] |    n    |
>       |--------------------------------------------------|
>       | AdvSIMD                      | [23-20] |    y    |
> -- 
> 2.14.3
> 
