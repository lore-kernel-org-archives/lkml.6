Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751798AbeCWP37 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:29:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:55367 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751553AbeCWP36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:29:58 -0400
Date: Fri, 23 Mar 2018 16:29:51 +0100
From: Borislav Petkov <bp@suse.de>
To: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc: Tony Luck <tony.luck@intel.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 0/8] Decode IA32/X64 CPER
Message-ID: <20180323152951.GB2487@cz.tnic>
References: <20180226193904.20532-1-Yazen.Ghannam@amd.com>
 <20180228084321.GA2969@pd.tnic>
 <DM5PR12MB1916B6CA08F0D423B3635EDDF8C70@DM5PR12MB1916.namprd12.prod.outlook.com>
 <20180228163539.GC2969@pd.tnic>
 <DM5PR12MB19169CD3BC3BAE3230C1DCA3F8C70@DM5PR12MB1916.namprd12.prod.outlook.com>
 <20180301115953.GA5040@pd.tnic>
 <DM5PR12MB1916C801C1340FB36B01DFF4F8A80@DM5PR12MB1916.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM5PR12MB1916C801C1340FB36B01DFF4F8A80@DM5PR12MB1916.namprd12.prod.outlook.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 12:19:20AM +0000, Ghannam, Yazen wrote:
> Is it alright if I go ahead and just send the v3 of this set without the MCA decoding?

Sure, but let's not drop the MCA decoding from the todo list. :)

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
