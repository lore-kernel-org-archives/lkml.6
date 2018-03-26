Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752031AbeCZUKs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 16:10:48 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38318 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750983AbeCZUKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 16:10:46 -0400
Date: Mon, 26 Mar 2018 22:09:55 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 2/2] x86/MCE: Always save MCA_{ADDR,MISC,SYND} register
 contents
Message-ID: <20180326200955.GG28372@pd.tnic>
References: <20180326191526.64314-1-Yazen.Ghannam@amd.com>
 <20180326191526.64314-2-Yazen.Ghannam@amd.com>
 <20180326193526.GK25548@pd.tnic>
 <DM5PR12MB1916CB8536B257923AC76CA7F8AD0@DM5PR12MB1916.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM5PR12MB1916CB8536B257923AC76CA7F8AD0@DM5PR12MB1916.namprd12.prod.outlook.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 08:05:37PM +0000, Ghannam, Yazen wrote:
> Sure, I can do that. But I didn't think it was necessary because it doesn't hurt
> to read the registers whether or not the valid bits are set.

No, this needs to be AMD-specific because it will confuse people using
Intel machines.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
