Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163057AbeBNTf5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 14:35:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:56132 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162917AbeBNTfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 14:35:54 -0500
Date: Wed, 14 Feb 2018 20:35:47 +0100
From: Borislav Petkov <bp@suse.de>
To: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 1/3] x86/MCE/AMD: Redo function to get SMCA bank type
Message-ID: <20180214193547.GB19502@pd.tnic>
References: <20180201184813.82253-1-Yazen.Ghannam@amd.com>
 <20180208150433.GD7964@pd.tnic>
 <DM5PR12MB1916E752AF9164228359BC9EF8F50@DM5PR12MB1916.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM5PR12MB1916E752AF9164228359BC9EF8F50@DM5PR12MB1916.namprd12.prod.outlook.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 04:38:34PM +0000, Ghannam, Yazen wrote:
> I know that we're declaring smca_banks[] to have MAX_NR_BANKS items. But
> shouldn't we directly check that an index is within the bounds of the array?
> We'll have a bug if we check against MAX_NR_BANKS and the definition of
> smca_banks[] changes.

Then we don't need MAX_NR_BANKS. We either keep them in sync or kill it.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
