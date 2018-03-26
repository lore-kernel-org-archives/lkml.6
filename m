Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751866AbeCZUIh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 16:08:37 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38166 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751157AbeCZUIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 16:08:36 -0400
Date: Mon, 26 Mar 2018 22:07:42 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 1/2] Revert "x86/mce/AMD: Collect error info even if
 valid bits are not set"
Message-ID: <20180326200742.GF28372@pd.tnic>
References: <20180326191526.64314-1-Yazen.Ghannam@amd.com>
 <20180326193052.GJ25548@pd.tnic>
 <DM5PR12MB191603A2AACAE6F7F923C6F3F8AD0@DM5PR12MB1916.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM5PR12MB191603A2AACAE6F7F923C6F3F8AD0@DM5PR12MB1916.namprd12.prod.outlook.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 07:58:51PM +0000, Ghannam, Yazen wrote:
> So at a minimum, we should always save and report as much as we can.

Only on Zen or all AMD families?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
