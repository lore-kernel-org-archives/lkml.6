Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751055AbeBQFAK (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 00:00:10 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:20258 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750803AbeBQFAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 00:00:08 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w1H4xxqE003684
X-Nifty-SrcIP: [209.85.213.42]
X-Google-Smtp-Source: AH8x2270w/XIDlXiFGY6512rYk5BiN3iYzrhP0y5A0VsFyYxgQjEgnX1uhpbruhuuqsJWMHq0u+mFaZTPKOGFbTgXPg=
MIME-Version: 1.0
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 17 Feb 2018 13:59:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNATZ1MZ8ktrzitgm-f7sT-hGXLz0KPvNb9wCf9xzNm0phw@mail.gmail.com>
Message-ID: <CAK7LNATZ1MZ8ktrzitgm-f7sT-hGXLz0KPvNb9wCf9xzNm0phw@mail.gmail.com>
Subject: Plan for DTC re-sync?
To: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc: Frank Rowand <frowand.list@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,


Do you have a plan to sync scripts/dtc/
with upstream?



I want the following commit in the upstream DTC project.

commit b260c4f610c004c6e9e36c5f7bbb58d23e605bf1
Author: Grant Likely <grant.likely@secretlab.ca>
Date:   Mon Nov 20 17:12:18 2017 +0000

    Fix ambiguous grammar for devicetree rule




-- 
Best Regards
Masahiro Yamada
