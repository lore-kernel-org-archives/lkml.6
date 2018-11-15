Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7BAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE082089D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE082089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dh-electronics.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbeKOSoh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:44:37 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:45805 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728388AbeKOSoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 13:44:37 -0500
Received: from sun05.dh.corp ([188.193.90.127]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPA (Nemesis) id
 1N8oKc-1fRctY2wPG-015rlD; Thu, 15 Nov 2018 09:37:38 +0100
Received: from sun1049.dh.corp (unknown [10.64.9.49])
        by sun05.dh.corp (Postfix) with ESMTP id 21A821FA3D;
        Thu, 15 Nov 2018 09:37:37 +0100 (CET)
Received: from SUN1049.dh.corp ([::1]) by sun1049.dh.corp ([::1]) with mapi id
 14.03.0415.000; Thu, 15 Nov 2018 09:37:47 +0100
From:   Christoph Niedermaier <cniedermaier@dh-electronics.de>
To:     Jonathan Corbet <corbet@lwn.net>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "C.Emde@osadl.org" <C.Emde@osadl.org>
Subject: Re: [PATCH 0/2] Docs/EDID: Fixed and improved EDID documentation
Thread-Topic: [PATCH 0/2] Docs/EDID: Fixed and improved EDID documentation
Thread-Index: AQHUdd372aKemkOCNEebpzMkutC1AKVQjpNA
Date:   Thu, 15 Nov 2018 08:37:47 +0000
Message-ID: <82DABEC7F9941D458E51BA62B2739EF437ADDC68@sun1049.dh.corp>
References: <1541407715-5417-1-git-send-email-cniedermaier@dh-electronics.de>
 <20181106073536.58b14759@lwn.net>
In-Reply-To: <20181106073536.58b14759@lwn.net>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.64.31.6]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Provags-ID: V03:K1:3gpRwVg0DfddqMMxRlhVAe8nZmznJkXzKBabZi3DPjMv/AiWVmy
 KoZ5CONs+PWe3A0aq1GsRvtf/krRW5UdmbfarLrv4bQPGl52nHUXzLn2PLKGbhVkP4ut/o4
 71UU9EplAq9WR85c7R0LFWPIZjJjLg1Z1yoz0JddMBy/G82RfQsZQBa5krEpJsYtqaDk2VK
 JQkutXXnBStDDs8TNOHyA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:z0y9+5KjkIA=:nYeAGj9Mz0at97cKPkC7Ja
 h4nB2mwbDOD5HuDKhvZBHL1GMWKl9cL1DIvHo2Z6l2SiwDDm8g9UDRAmPS3kPftvYp0Ymnj84
 x9nVVjPlEnp4S4Dcag5MoNXLQq51Fg1TtDYkOn2p6BHcUySXtPonbEhDtBgc51yNXWV8+82Fi
 4GA0VnXtTP2LNb+FidXEo3hkFHJ/MhB9zZL5XE71ElshAfqRVyQaJkc4O8gXyIVBxl7+wrgj5
 GJ+r9WECfFcPRTAHpBGlxLQ+bZv7Gw8C4zwHRI6N3QwSoute48+M0Q4KkLrm7+JlN4ZeE1k6d
 qRcyXYVdDsoxJdo2XTc22hsq9muDalkPlnFA3phHF4xDDdnrIm1/XCFsrS0dbJRwBfkNZQDJX
 H4+HV4cmPigL2MLdepFy64Icuk7pp2u9VxXpLMr86KcdT6FSv4pL9WBtXRbgRbDlw4gp2htpi
 qtJtv6oT+Z/2VfqfrX9NUkKm3rccxVUeshzZaaT8CXF7LrNBLoAlZ6a2xJ6tW+rVjiX19gfLY
 RefX7cQt+o0tnrpFapRy4YbEXCimYQSWIDezyrDsvob1IUL5iY/JI8vksdg+QOV+jB4FO3qtH
 RT/VGw4z4MA+dnyPwuHNTIpAOXO7PALa1gf5cGK+GER9o7/TrMn04KgeIuZ0zdHAhhhi/vbaF
 a2CxBTigtmCRac9UiUvvlp0V7iJPzF6mxyAlA0+ahT+2rFcMXGLOabEDGbGaCUKenp3w5ynXV
 FykCPbB0eFIPyr014GaEtzm+ohrC6J8HcdNJ0RpVGEmrDDU09HMxcp35tIqoKFtyPYTN641z1
 +dbxVKF36XpjE0ob6l3QEUENAX/Hk5+8BPuYdqaXJBgr4cw1CM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

On Tue, Nov 6, 2018, Jonathan Corbet wrote:
> This seems reasonable, I guess; I've applied both.  It seems to me, though,
> that this stuff is in the wrong place.  Perhaps we should go one step
> further and move it to tools/ ?

I spoke to Carsten and his intention apparently was to merely document
how the somewhat cryptic data structures in drivers/gpu/drm/drm_edid_load.c
were derived. The code needed to be run only once to generate the data and
never again. So it not really is a tool that someone may want to run from time
to time for a particular purpose. So we would propose to leave the EDID directory
where it currently is. However, should you feel that it would better be placed
in the tools directory then you certainly may do that.

Best regards,
Christoph
