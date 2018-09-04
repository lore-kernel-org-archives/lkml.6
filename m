Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BDAC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7659206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=autovalidinfo.com header.i=@autovalidinfo.com header.b="niodbRHf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7659206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=autovalidinfo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbeIDXBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 19:01:41 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:34897 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeIDXBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 19:01:41 -0400
Received: by mail-io0-f199.google.com with SMTP id r206-v6so4436360iod.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 11:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=autovalidinfo.com; s=google;
        h=mime-version:message-id:date:subject:from:to;
        bh=klShlQa21PX+xLH5Bk3K31Y+7fYGmcBFv3snWV1kces=;
        b=niodbRHfbDlFL05YPiv6+wFaA6w8bQgV0Xe1zDWHnqRn8fQ7b+P2Oo7L1vJeQpfdHB
         Y2pWM62/zfKXX7eed39HMN91W/wK8jjZ81pUSIM/n1Qro6aRScN21225TlhByxyBJLEF
         H9lFhVQBC+sNTJ0qf9+OzkJ/skrKK6jSTvhvlhFTy8qVElBQhueAezUpEC3KzW4468uX
         mqbgSOB9aS/HkBgG42bHiQOJTU0xBIxaKvA+/DYJsdXLaySrAIh+mE68ayloscJe1vps
         59NFaj2izCdlz+a6K4wIVHQJfQmFkUROrjk8V+tMgEBgCxTNetbPIrWTQMPOHXT27PdT
         u4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:message-id:date:subject:from:to;
        bh=klShlQa21PX+xLH5Bk3K31Y+7fYGmcBFv3snWV1kces=;
        b=kYnVvhD1vCKNph8kO0PId8jhS8BgJnrND6vbB2rQovEgqIstTbw8mA0s/zagiJS13A
         ReUtCoENdHmhuLoHlTkmhfmzbJCgwhf61mbanxxiBdpOLNI0EXXwtCyeTMyR26yNLqNL
         pJf/tKC5hcsDGVNOUnTs/nPCBS4mqyB7vjPRZPuWQupZNKVLQyU1MXNWXSrmIqLSRqP4
         owacqKVFI34rqcrmGtedKw8vVnI+Tqaj98KXxfDhv98MYpQhCWB08hd09l0UK0CH4iIk
         Fp/C+hMaIP1d2xDL69WaOxz44A7AvDd3yhMDFWiPCdUBmJ8iobUo7/gOmznMN56gmNQe
         JSqA==
X-Gm-Message-State: APzg51BBCwwuZ5cynOWEB84ImcYRTDABVUOaI00kPTvP3B9QROm1uMw9
        7aAYuvaZ9HVBs+RVLPmTJ62lFt3+dMaV
X-Google-Smtp-Source: ANB0VdaAdnMqqgZWBv+Q455YoJWBMd/AB+GZc0xoILuzCASaweh80fGMilHLAvEpimI4oX7PseT5eX7Cdg==
MIME-Version: 1.0
X-Received: by 2002:a6b:b3d4:: with SMTP id c203-v6mr15091440iof.53.1536086121526;
 Tue, 04 Sep 2018 11:35:21 -0700 (PDT)
Message-ID: <0000000000009e3a4205750febdc@google.com>
Date:   Tue, 04 Sep 2018 18:35:21 +0000
Subject: Targeted Global B2B Companies emails list
From:   theresa.billy@autovalidinfo.com
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Hope all is well!

We are a database organization. We provide business executives' contact  
information.

Below, I've included a few examples:

Industry-Specific Lists: Agriculture, Business Services, Chambers of  
Commerce, Cities, Towns & Municipalities, Construction, Consumer Services,  
Cultural, Education, Energy, Utilities & Waste Treatment, Finance,  
Government, Healthcare, Hospitality, Insurance, Law Firms & Legal Services,  
Manufacturing, Media & Internet, Metals & Mining, Organizations, Real  
Estate, Retail, Software, Telecommunications, Transportation, and more!

Technology-Specific Lists: SAP users, PeopleSoft users, SIEBEL customers,  
Oracle Application customers, Microsoft Dynamic users, Sales force users,  
Microsoft Exchange users, QuickBooks, Lawson users, Act users, JD Edward  
users, ASP users, Microsoft GP Applications users, Net Suite users, IBM  
DBMS Application users, McAfee users, MS Dynamics GP (Great Plains), and  
many more.

Title-Specific Lists: C-level executives: CEO, CFO, CIO, CTO, CMO, CISO,  
CSO, COO Key decision-makers: All C-level, VP-level, and Director-level  
executives HR Executives: VP of HR, HR Director & HR Manager, etc.   
Marketing Executives: CMO, VP of Marketing, Director of Marketing,  
Marketing Managers IT Executives: CIO, CTO, CISO, IT-VP, IT-Director, IT  
Manager, MIS Manager, etc.

Please keep me informed for any additional details. I look forward to  
hearing from you.


Best regards,
Theresa Billy

