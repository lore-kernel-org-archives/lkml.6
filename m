Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752197AbeEQT3e (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 15:29:34 -0400
Received: from freki.datenkhaos.de ([81.7.17.101]:43542 "EHLO
        freki.datenkhaos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752014AbeEQT3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 15:29:31 -0400
Date: Thu, 17 May 2018 21:29:23 +0200
From: Johannes Hirte <johannes.hirte@datenkhaos.de>
To: Borislav Petkov <bp@suse.de>
Cc: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 3/3] x86/MCE/AMD: Get address from already initialized
 block
Message-ID: <20180517192922.GA11686@probook>
References: <20180201184813.82253-1-Yazen.Ghannam@amd.com>
 <20180201184813.82253-3-Yazen.Ghannam@amd.com>
 <20180414004230.GA2033@probook>
 <20180416115624.GA1543@probook>
 <CY4PR12MB1557FB8EB5C17E55A9B405D8F8B70@CY4PR12MB1557.namprd12.prod.outlook.com>
 <20180515093953.GA1746@probook>
 <20180516224641.GA31929@pd.tnic>
 <20180517064930.GA26421@probook>
 <20180517104124.GA25595@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180517104124.GA25595@pd.tnic>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018 Mai 17, Borislav Petkov wrote:
> On Thu, May 17, 2018 at 08:49:31AM +0200, Johannes Hirte wrote:
> > Maybe I'm missing something, but those RDMSR IPSs don't happen on
> > pre-SMCA systems, right? So the caching should be avoided here, cause
> > the whole lookup looks more expensive to me than the simple switch-block
> > in get_block_address.
> 
> Yeah, and we should simply cache all those MSR values as I suggested then.
> 
> The patch at the end should fix your issue.
> 

Works as expected on my Carrizo.

-- 
Regards,
  Johannes
