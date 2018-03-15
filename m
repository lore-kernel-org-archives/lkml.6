Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751817AbeCOJGb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 05:06:31 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:22097 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751755AbeCOJG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 05:06:29 -0400
From: Patrice CHOTARD <patrice.chotard@st.com>
To: "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "arm@kernel.org" <arm@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Patrice CHOTARD <patrice.chotard@st.com>
Subject: [GIT PULL] STi DT update for v4.17 round 2
Thread-Topic: [GIT PULL] STi DT update for v4.17 round 2
Thread-Index: AQHTvDzXpYopfEu1o0+2IKDEW9xFQQ==
Date: Thu, 15 Mar 2018 09:06:01 +0000
Message-ID: <af473935-7cb6-e59a-3b52-055d8492248c@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F929E22060A714FB5FB2C8A6C45BC2C@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-15_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2F96dQa008408

Hi Arnd, Kevin, Olof

PLease consider this second round of STi dts update for v4.17

The following changes since commit 0e04ce02e6a2ac30d21294d8bb2aeceb8489e52b:

   ARM: dts: STi: Remove unused clk_ext2f_a9 clock (2018-02-13 13:31:38 
+0100)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git

for you to fetch changes up to 9a5f4879cd8de167e82f335317c63f2ffdc80129:

   ARM: dts: stih4xx: Add missing #sound-dai-cells (2018-03-15 09:52:25 
+0100)

----------------------------------------------------------------

STi DT update:

Add missing #sound-dai-cells which fix DT dtc warnings when building 
with W=1

----------------------------------------------------------------
Rob Herring (1):
       ARM: dts: stih4xx: Add missing #sound-dai-cells

  arch/arm/boot/dts/stih407.dtsi | 1 +
  arch/arm/boot/dts/stih410.dtsi | 1 +
  2 files changed, 2 insertions(+)
