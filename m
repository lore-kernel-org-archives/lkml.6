Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754789AbeENP4i (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 11:56:38 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:64921 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752940AbeENP4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 11:56:35 -0400
From: Patrice CHOTARD <patrice.chotard@st.com>
To: "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "arm@kernel.org" <arm@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Patrice CHOTARD <patrice.chotard@st.com>
Subject: [GIT PULL] STi DT update for v4.18 round 1
Thread-Topic: [GIT PULL] STi DT update for v4.18 round 1
Thread-Index: AQHT65wSo8Ml0XhqmU+iwJzbaPtPSg==
Date: Mon, 14 May 2018 15:56:08 +0000
Message-ID: <11f8376c-860d-26cf-92f6-38737e513656@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <805E2FD95C314641834B4F64161941FF@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4EFuhSU008019

Hi Arnd, Kevin, Olof

PLease consider this first round of STi dts update for v4.18

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git 
tags/sti-dt-for-v4.18-round1

for you to fetch changes up to c5bf208a0dc4aee18e03c6ed97eada70ffa9a4d8:

   ARM: dts: stihxxx-b2120: Fix complain about IRQ_TYPE_NONE usage 
(2018-05-14 17:40:26 +0200)

----------------------------------------------------------------
STi DT update for 4.18:
  - Fix complain about IRQ_TYPE_NONE_usage

----------------------------------------------------------------
Patrice Chotard (5):
       ARM: dts: stih407-family: Fix complain about IRQ_TYPE_NONE usage
       ARM: dts: stih407-pinctrl: Fix complain about IRQ_TYPE_NONE usage
       ARM: dts: stih407: Fix complain about IRQ_TYPE_NONE usage
       ARM: dts: stih410: Fix complain about IRQ_TYPE_NONE usage
       ARM: dts: stihxxx-b2120: Fix complain about IRQ_TYPE_NONE usage

  arch/arm/boot/dts/stih407-family.dtsi  | 52 
+++++++++++++++++-----------------
  arch/arm/boot/dts/stih407-pinctrl.dtsi | 10 +++----
  arch/arm/boot/dts/stih407.dtsi         |  2 +-
  arch/arm/boot/dts/stih410.dtsi         | 18 ++++++------
  arch/arm/boot/dts/stihxxx-b2120.dtsi   |  4 +--
  5 files changed, 43 insertions(+), 43 deletions(-)
