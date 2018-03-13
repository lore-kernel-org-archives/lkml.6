Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932824AbeCMKsg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 06:48:36 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41852 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932514AbeCMKsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 06:48:33 -0400
Date: Tue, 13 Mar 2018 11:48:11 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC, sb_edac: Remove VLA usage
Message-ID: <20180313104811.GA23568@pd.tnic>
References: <20180309235654.GA9887@embeddedor.com>
 <20180310140434.GC8261@pd.tnic>
 <f875ba4f-65d0-0f13-850d-f323306b8e13@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f875ba4f-65d0-0f13-850d-f323306b8e13@embeddedor.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 05:52:13PM -0500, Gustavo A. R. Silva wrote:
> Do you mean just adding a code comment?

No, I mean

#define MAX_INTERLEAVE (max_t(unsigned int, ARRAY_SIZE(knl_interleave_list), ...

which computes the max of all three array sizes.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
