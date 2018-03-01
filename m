Return-Path: <amelie.delaunay@st.com>
X-Google-Smtp-Source: AG47ELvHCsw75J0NP/h77y6K0u/G09KuZJK5+iizFocS4QGUdSM1GWYgWB9CAF1m9NKdjkywdGYa
ARC-Seal: i=1; a=rsa-sha256; t=1519898749; cv=none;
        d=google.com; s=arc-20160816;
        b=Z27wDQX1n6jFBXBAuwjJQLFNVK8up4BtSCSf8QyE5+BBXtEWjq1ZxyToXnLwb0qtv5
         HVjQeSbu7en2fvtgsg5YTaeWjYcL17mZn0D45IbHoR4skeXIF+dBUSlpuDteg5WMlnXE
         RB2oIeiFFC58OXmMxzr/77nTQ8vZ6z2JsU1mqLWZe2IMsxCDXKrPMO7wjluTEoVTbcgW
         m27f8ag9ydf2UKsQFa10s1M/HThDK9xja0PZ7BWejgaymZkttV9KSDiCXTvn6orq7nKL
         bWhlWGVJUMRJKKP+IzCLDOqoNBbdTrRYrY0pxODAbidSbVfBy1e6AM30j6lhreAFqGbF
         Vpuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=iIX/jMQjxCNeUXNjm/s44xQVGL0ibhFwaOsMtCOqupI=;
        b=pRKNcEU7l+vFSDMBSerkZAM2EuKAPJTJSb62vcxSPbjnecYdHRdqNTmcoj2JyOICC+
         pcRW2p94Ntdhs6hAQKOuPXe5Yz84aVVlqP1QzCEQQWOHyGWmNiAlAxsYBZ9UJDKFnAV8
         V2jj4PmAfAIkBxk+AfLhfKuRo7DOgyQE1nOSzYrqyWDBRK2lczGGUy1fw6Cm8P4nBx+g
         1zytYKmdgBDoSuE1yrvLU6zLXlowsWo2WGNi0fWn1bIq0d4QZpUvuCstYhh4CLe9sVGS
         hgvsDlXT000rW718yX1b0O1XnxfgQv5rkoitHli5giZDppd18kgrS1z3WfHpXpzQV6C5
         Xldg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of amelie.delaunay@st.com designates 91.207.212.93 as permitted sender) smtp.mailfrom=amelie.delaunay@st.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of amelie.delaunay@st.com designates 91.207.212.93 as permitted sender) smtp.mailfrom=amelie.delaunay@st.com
From: Amelie Delaunay <amelie.delaunay@st.com>
To: John Youn <johnyoun@synopsys.com>, Felipe Balbi <balbi@kernel.org>,
        "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring
	<robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
CC: <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH RESEND 0/2] Fix STM32F7 DWC2 OTG HS binding
Date: Thu, 1 Mar 2018 11:05:33 +0100
Message-ID: <1519898735-10319-1-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_05:,,
 signatures=0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593729351308575201?=
X-GMAIL-MSGID: =?utf-8?q?1593729351308575201?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patchset fixes STM32F7 DWC2 OTG HS binding. It actually
re-applies the v2 former patches adding STM32F7 DWC2 OTG HS support.
Bindings reviewed by Rob Herring.

Amelie Delaunay (2):
  dt-bindings: usb: fix the STM32F7 DWC2 OTG HS core binding
  usb: dwc2: fix STM32F7 USB OTG HS compatible

 Documentation/devicetree/bindings/usb/dwc2.txt | 2 +-
 drivers/usb/dwc2/params.c                      | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.7.4
