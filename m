Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752291AbeB0RHT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 12:07:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:47808 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752093AbeB0RHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 12:07:16 -0500
Date: Tue, 27 Feb 2018 18:06:54 +0100
From: Borislav Petkov <bp@suse.de>
To: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 5/8] efi: Decode IA32/X64 Cache, TLB, and Bus Check
 structures
Message-ID: <20180227170654.GL26382@pd.tnic>
References: <20180226193904.20532-1-Yazen.Ghannam@amd.com>
 <20180226193904.20532-6-Yazen.Ghannam@amd.com>
 <20180227150356.GH26382@pd.tnic>
 <DM5PR12MB1916C11E8B578EBA43CE2B82F8C00@DM5PR12MB1916.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM5PR12MB1916C11E8B578EBA43CE2B82F8C00@DM5PR12MB1916.namprd12.prod.outlook.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 03:33:44PM +0000, Ghannam, Yazen wrote:
> I agree which is why I've included the Validation Bits. A user can then
> check the Validation Bits for any field that is of interest but missing.

No, no half-baked fields.

So you know drivers/edac/mce_amd.c, right? And you know the lengths we
go to make an error record as readable as possible?

So please apply the same logic and intent here too.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
