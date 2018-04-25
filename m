Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-721450-1524661047-2-7097580115870509793
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524661047; b=PIC2XUVU7NQUOFOG2sOVfp75Unkaxz4Z8+22ITk0JF0+4jKPHV
    V4o2rSvtfJVvNnkhP5loXCiI+v8B0hEQQkz2PepPVIDzYN1GSwjcD1hr+py2kZfY
    ztvGNvbvz50akKnfHMe2rngGJwNAeD9ne2oaDCh0NaMxQoBlUR/XmG4hibaqEt5P
    seDi7Ej9ssD7F+IveVZFE8dVwhPrPJDc/TiNCVswdgRaBOKbAAYs2ylUBQcavYge
    EQAGMY06LUafa4qKhXqUDttFlSWXp5p+HMfOv/tkiHqBK6QLhCRHI/W3cOpglCqi
    43z0uIbc2LVYmYHa59kMdv+5R68TLzEkswcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:from:message-id:date
    :mime-version:in-reply-to:content-type:content-transfer-encoding
    :references:sender:list-id; s=fm2; t=1524661047; bh=7YscCt/25c2j
    yyJKfxlBCuvm3pc0KedFjW+BWIk5UeA=; b=QHcg7G66XjdvLWTl4cSplXZ/nldO
    pgyIWGfTn4zpe6BiUiYx+k2HMU0GJwUK76lfTMJ9Lh3QV59LgblaDh8rYabdO52V
    1shvltqqbWSS29xNplJYCvUkcrwf/lNOgfFvLn95qLW8Bz8c2ZHiD8NLvII+l760
    hi+KIL1YbGMfDSOmJ2G75je9fdtrqLj906mieBQZAtjofzk+TxFPxCTG3LXskRLL
    5ral1cVuoxiX5hxxWDntsjwDwlyBYc0Im705xgs5Lml6zif79lAeASvQdasa2i9z
    JMvaCNjnD3BDqQPRRMNsZGQotl6GD4e/JJ2j+PSAHRiQd9MhGwTkbqZlaA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=hdCE1VO0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=hdCE1VO0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ6+lGLf4LhiXqcJstpNc82gaX6eISMrqCcgp9aMmOAM1moeFZFQ3izk9STWJHoOh4evolRJ84nN85UJJy2xuKoOhHmljwRDrA4AVH3i5i922vFEspw7
    6yfKG0TIy5VXBAfkJ1FzYwnWcuJx5Kh5TJ4p7H6kj9DjDmzhGtn6+55+Icq2dk/Tkvaufoe7R4OgxwvlfeV908owkpYFjXdem/DZqQklZ88xc0ZBuh01zyZn
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=bFUnhJpB9Z3-8uSK8OwA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754474AbeDYM5W (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 08:57:22 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:18335 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754444AbeDYM5F (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 25 Apr 2018 08:57:05 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180425125702epoutp042af6faf2f7ba996de0d46dbddebce0d0~orx823EsZ2249222492epoutp04p
X-AuditID: b6c32a36-b6dff70000001027-de-5ae07b1deb15
Subject: Re: [RFC 05/10] i2c: s3c2410: Remove support for Exynos5440
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>, linux-i2c@vger.kernel.org
Cc: Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Tejun Heo <tj@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jaehoon Chung <jh80.chung@samsung.com>
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <fe4ac171-e7dd-a643-35b6-7beebee81bdb@samsung.com>
Date: Wed, 25 Apr 2018 14:56:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-version: 1.0
In-reply-to: <20180424203239.21885-6-krzk@kernel.org>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUyTVxTHd593mnV7rGycaJSkgw8QdLAXc5I5s2U6bxY/LCxRbGJmM58h
        gSJpwchIVNhgwqQ6VjdTca7gRgI1LZQsyAST8ioSkMqLiFAUGGOuQycoUNhGeTDhy83vnPM/
        99z/yZVY3V1hg5SSnqmY041pekHD/doUs2XLppxRQ/x/7lgsn5tkcKmkVcTq8y4ez90fF3Bg
        ZpLHS81dy0dvP49flrsE/KvtBwbvLBTweGbsIYvd3W4RbYsVDNaMLUsenx7h0XNpkeCppRmC
        rXUPGLxdXyrgk+Jmgue7GxnMfTwoYtkv+Sx6zzUQvNI8LOLPAz0M9nTswo6BJwJ23vTxmN/Q
        LOL4fauA//ZXc3g2eEvAhYoWgpX1y7dXz9L3oqjzRyeht/t7WBpcKCF0+k6+SAcu/8PSq/Zh
        kZZfm2JoTWWhQO/1XxPo9YtOkXoun6C97Xk8nW7sE2ht39ccvTA8R6i1tpJ8vM6g2X5ISUs5
        qphf33FQczi33sVlTDDHfp8vJCdJFVNEwiSQ34IbD67yRUQj6eQ6AmOBoKAGzwiUlo+yz1Wu
        LhunFn4jMDTeRNTATyDg6yMh1Xp5J4xWBVc4XE6D8Ss2NiRiZXcY1HQurBQEOQGKW6zLLEla
        eQd8U5AVSnNyNPgeeYUQvyInQd7kvBhirbwO5r4b4UIcJr8NU858PsSsHAN/zJRwKkdAq3+Q
        qBwJHmdgZS7IjyRwdM2vGt0JHYN1ROX18GdbrRh6A8gbwdfyrprOgcKCIlHt/YrA4vc+QS28
        A01tPauDX4K/Z0/zaq8WThXoVAmFOUdwdVvvg2PCurogDwGPzS+eJZvta/zY13iwr/FgX+Ph
        J8JVkleVDIspWbEkZLyx1WI0WbLSk7d+dsRUQ1Z+fOy2OlLWtcdLZInoX9TG7/cbdLzxqCXb
        5CUgsfpwbcPmEYNOe8iY/YViPvKpOStNsXjJRonTR2gn9nQadHKyMVNJVZQMxfy8ykhhG06S
        hu3ebY00Lqr4Qi9NjHtmP3jCPVTqz7NORviXEs7cGz7ueiGQGPk0NzoyNbu3PTlR8+HD3S9n
        Wq2++CRPzt0D7buqhqJv0tpPyo7HfpQ0dUzv3Ds99TmYrjveHJGeXsyJwrjAvvkIITwYY3FU
        NH6rTwmMbnptd5FnNhU/sLmTUvWc5bAxIZY1W4z/A5ILyo7tAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0zTZxSH8/7vZTZ5rU5elOBSNRIS3VhmOCTOmEXnq9kHo4nRmogV/ilC
        W5oWcGzGyTYYgqLRCq4iuFE1KUWkEC9E1JWLKAsdF1uKUq5q2DRaYQsDRVvJMr6cPOec33M+
        HYlV1fKLpf3GTNls1OrVQgTXPjOCV0V/O6j5pKMvESonnzLw5mSrCLVnang4PTQqgG/iKQ8V
        zR2h0uPl4YfKGgGe3S1loHcqn4fjI3+x4PFcEcH6+hIDrpFQJHg0wENdxWsEBW8mELReH2ag
        u6FMgPFjzQjOeG4xkBv0i/DrxTwW3KcbEVQ394twwdfJQOf9jXDfNy7A7+1dPOQ1NoswOlQs
        wIy3loMT038IMHWpBYGjIXS99m+6fjl1ljsR7fZ2snR66iSiL3rzROqzv2LpDVu/SCtvjjHU
        5Tgi0EfemwK9fc4p0jr7d7Sn7Xuevrj1QKD1D37i6Nn+SUSL6x1o63xNxNoUWb8/WzZ/vG5v
        RGpuQw1nesx8/eTfI+gwqmIKkUIi+DNS02HlClGEpMI3ELnS5BJmmyFEjvruiOHUAryBDFZN
        ozAvxHrSNTgjhkMsdilIS085O2vUIVIWsL43BBxPjrUUhwxJUuJ1pCg/Kzzm8ArS9dIthPlD
        vJMEPK/esxLPJ5OnAlyYFXgNGXPm8WGVxSuJ1WoIj1kcSVoH/GiWl5I653P2BMK2Obbtf8M2
        x7DNMc4jzoGiZJPFoDNYPjXFG+UDqy1agyXLqFudnGFwodAjXW2KK76OBuxJboQlpJ6n7N0x
        oFHx2mxLjsGNiMSqFyobYwIalTJFm/ONbM5IMmfpZYsbLZE4daTyobF1lwrrtJlyuiybZPN/
        W0ZSLD6MisrSRsq/1FRfu/zbF6X/7I5ua9w2dWhRaXtydcEyPX3s+dHRfe5aTOJ6/+a22OGo
        20V2bZE/7ef6plzb6LP6lOiSyODLio8S0u99HvzFGyzRZWyi/rSYXaZg1Z7x/AXpYx/YUiO3
        D0cnPF+0Vaf7yl64D/pit4zD4MHlBX++nShRJKg5S6o2Po41W7TvAKl+MINEAwAA
X-CMS-MailID: 20180425125701epcas1p3aa1827026d80359d540fb43979092706
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180424203349epcas2p1a47060486c2e349b27fd0b2c4ea0394c
X-RootMTR: 20180424203349epcas2p1a47060486c2e349b27fd0b2c4ea0394c
References: <20180424203239.21885-1-krzk@kernel.org>
        <CGME20180424203349epcas2p1a47060486c2e349b27fd0b2c4ea0394c@epcas2p1.samsung.com>
        <20180424203239.21885-6-krzk@kernel.org>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/24/2018 10:32 PM, Krzysztof Kozlowski wrote:
> The Exynos5440 is not actively developed, there are no development
> boards available and probably there are no real products with it.
> Remove wide-tree support for Exynos5440.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

