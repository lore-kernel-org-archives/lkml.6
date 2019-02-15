Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0B1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE8B222A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=itmarketsintelligence-com.20150623.gappssmtp.com header.i=@itmarketsintelligence-com.20150623.gappssmtp.com header.b="IP3zf2dM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731258AbfBOTbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:31:17 -0500
Received: from mail-qt1-f200.google.com ([209.85.160.200]:54215 "EHLO
        mail-qt1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730613AbfBOTbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:31:17 -0500
Received: by mail-qt1-f200.google.com with SMTP id k37so9961055qtb.20
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 11:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=itmarketsintelligence-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:message-id:date:subject:from:to;
        bh=Z0tkzToy63MSaLYsw4NHH5Pc9MUwcTwslQQ8+TymNvE=;
        b=IP3zf2dMOOrESEYDNqw7cEr552bCxWxaRcTIdJYWaVLAJVl0anMYr9pvSmRQeKEESG
         QPcwzzrAgD6WKV3kEt7K4egmGNUXgqVyp4vg2yih5l3CaLKtWdiM0H7bDw26ud0Snc6u
         YGOMIwLP4/CSJ+MRJvG9PxReFSP3U3bEvdYQnBGjKq76zmaD4E7nmH8Q9R1kq9o59U9e
         1V+GxN+2lE8wnyHl1G27yM8gJijbFk7NE2Rf5dKGsMbfnOg1Wu+G06BGOralActo3cgD
         sA75NopGJPBAoAiO4UvBX+Z2GiHmNzCaEWYoDL5zZ0yViZPGCICCxS0WW3fa+RaslIMg
         XR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:message-id:date:subject:from:to;
        bh=Z0tkzToy63MSaLYsw4NHH5Pc9MUwcTwslQQ8+TymNvE=;
        b=ENyHVuaj2v7I4jUJVSSo0togKa1kutVdnBYhS2dtXj+TYhB9KzKcyv4nfZZL3bzEV8
         f8UlZtSFfzPUeVc66g/xVX3zGHJhjsUSWwC63DSE5uBmLAC3Se0avV5ztpAzD0nHsznh
         OIS35slowNSK0tDTsHxCkt0eoQ/EvonZpYTz+iNjvAyx4XxZAZ2TgspwVR8dVVEFM21X
         JSYVv8TSg37grJljY9Po6c56GmQ3uDuqnTHHM3jPbsLUCB0l/OKbbz3mJg9I9ZLaJ7RE
         1NuGzmLPf95hNR6H284tmGis75ii9xfa8N2GzRd8pNJS5b1R5u/EP3lILebGxZTNuJaK
         F1fg==
X-Gm-Message-State: AHQUAubU2LoXPxHsoh15iWQl45WExVnF2TRQkhavzylJUZkH4qFVKSvO
        UJLAHABMd68c/K+AezDvGYSuUJ/apNhp
X-Google-Smtp-Source: AHgI3IYwRzhg45B2llM5/gLlWxDg16n340Cfus78If8+3/4oEJrwABxqMfyWguPWD2lXXQDwmmoY8mOFew==
MIME-Version: 1.0
X-Received: by 2002:ac8:362e:: with SMTP id m43mr6362308qtb.53.1550259076319;
 Fri, 15 Feb 2019 11:31:16 -0800 (PST)
Message-ID: <0000000000008dcf750581f3d18c@google.com>
Date:   Fri, 15 Feb 2019 19:31:16 +0000
Subject: Decision makers contact list
From:   martha.evans@itmarketsintelligence.com
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Would you be interested in targeting Cybersecurity Users across the globe  
for your Q1 marketing strategy?

Here is how we can help you:

Security users by vendor: Cisco, Juniper, Check Point, Aruba Networks,  
Symantec and many others.

Security users by security solution: Email, SIEM, Firewall, UTM, Endpoint,  
DDoS, IAM, Cloud security, App security, Web security, Vulnerability, VPN,  
Authentication and many others.

Cloud users of IaaS, PaaS and SaaS: AWS, Azure, Rackspace, vCloud,  
Salesforce, Jira, ServiceNow, SharePoint, Office 365, Box, Workday,  
SuccessFactors and many others.

For Channel and Partner: MSP, MSSP and CSP companies decision makers,  
Industry specific IT security decision makers Banks, Credit unions,  
Insurance, Education, Healthcare, Retail, Manufacturing, Government, Oil  
and Gas and many others.

We can customize this list as per your specific technology, revenue size of  
companies and job titles from those companies.

Await for your positive response!

Thanks,
Martha Evans

If not, I would be happy to update my notes I just need to hear from you  
first!
