Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F88AC43615
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 21:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B79208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 21:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B79208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbeHXBCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 21:02:07 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42771 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbeHXBCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 21:02:05 -0400
Received: by mail-qt0-f193.google.com with SMTP id z8-v6so7989420qto.9;
        Thu, 23 Aug 2018 14:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZcGWmls/u4mJmJke+iZ+ogxvPYjyAhmOQIIbsQZzVuU=;
        b=OBIelQZWJyPAG5rO5K0Rmsk+IiJ6F+xXz0MjnQoolYgaXxYJ4TzLyrOysm/0lP6JS0
         3cFDVUPNureCv/0TKjPiPMn1zDzFP2LjyemKp48oaZJE12tVlFgnUq7PGIB79yxiFRMN
         7PK7CwAQPC7d36S+QJ4/J7GpAB4/D5Z+p8ECOFg8WEtZOslnkHmCH7JK/CJXhIOMvPLh
         mgbPD7stpoXp5HYoMGNmtZoVUPtf2JtNFWJvUw+qHPEDAKZLpqJXOMkONE20xJ/961vx
         bWFFezIWsOmwClgdYj0vRHqse8ZvvoApQFljvkqiNrVHimh4Pwf9WAUg4jAX34Ts4X7J
         6Ydw==
X-Gm-Message-State: APzg51CULdBC35l9G2i3V4obwzcXgCU9gM8hfnSewMU9Pm2821SnECk+
        5ezQkyqI3NIVOpWc/t2mXQCJVqdokaMTFCwb2CA=
X-Google-Smtp-Source: ANB0VdZv92sRiu3aUPqj36U0Dex/RruUEquoWzOp7XbChmB7qsJPAWtJrneM9E97TGBzKJIoGaT0bzj59auji1fC43I=
X-Received: by 2002:ac8:6959:: with SMTP id n25-v6mr15156716qtr.9.1535059830007;
 Thu, 23 Aug 2018 14:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180823140917.3060915-1-arnd@arndb.de> <090d76e5-25ef-349c-3160-3f74c9196b38@canonical.com>
In-Reply-To: <090d76e5-25ef-349c-3160-3f74c9196b38@canonical.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 23 Aug 2018 23:30:13 +0200
Message-ID: <CAK8P3a1VUt3zyP6s_aa4rXcN0Eundh2rFHBsxMxqd0_3ffXAwA@mail.gmail.com>
Subject: Re: [PATCH] apparmor: remove unused label
To:     John Johansen <john.johansen@canonical.com>
Cc:     jmorris@namei.org, "Serge E. Hallyn" <serge@hallyn.com>,
        Seth Arnold <seth.arnold@canonical.com>, mjg59@google.com,
        Kees Cook <keescook@chromium.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 8:21 PM John Johansen
<john.johansen@canonical.com> wrote:
>
> On 08/23/2018 07:09 AM, Arnd Bergmann wrote:
>
> thank you for the patch, but a fix for this issue was pushed to apparmor-next yesterday
>

Ok, good. As several people pointed out, my patch was also wrong, so that
saves me doing another one ;-)

     Arnd
