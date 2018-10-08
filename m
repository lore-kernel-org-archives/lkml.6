Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A6DC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0DD22087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0DD22087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbeJIByW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:54:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:20964 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729930AbeJIByW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:54:22 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2018 11:41:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,357,1534834800"; 
   d="scan'208";a="90243779"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga003.jf.intel.com with ESMTP; 08 Oct 2018 11:41:15 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id AA010301B7B; Mon,  8 Oct 2018 11:41:15 -0700 (PDT)
Date:   Mon, 8 Oct 2018 11:41:15 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/5] tools, perf, script: Add --insn-trace for
 instruction decoding
Message-ID: <20181008184115.GJ32651@tassilo.jf.intel.com>
References: <20180920180540.14039-1-andi@firstfloor.org>
 <20180920180540.14039-2-andi@firstfloor.org>
 <20181008180314.GT3541@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008180314.GT3541@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +> git clone https://github.com/intelxed/mbuild.git mbuild                                                                                        
> > +> git clone https://github.com/intelxed/xed                                                                                                      
> > +> cd xed                                                                                                                                         
> > +> mkdir obj                                                                                                                                      
> > +> cd obj                                                                                                                                         
> > +> ../mfile.py                                                                                                                                    
> > +> sudo ../mfile.py --prefix=/usr/local install    


Need 

../mfile.py examples
sudo ../mfile.py --prefix=/usr/local examples install


-Andi

