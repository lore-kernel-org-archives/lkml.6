Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751734AbeFEKdj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 06:33:39 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35440 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751534AbeFEKdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 06:33:37 -0400
X-Google-Smtp-Source: ADUXVKIqCZSz9mK+Bxm8qRRFf1NpOLaVTj8l0ozr+zKoyxPxiPlFABNOwsSbJ/QOHwYNEONUM0cIBw==
From: Tomasz Figa <tfiga@chromium.org>
To: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        =?UTF-8?q?Pawe=C5=82=20O=C5=9Bciak?= <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Kamil Debski <kamil@wypas.org>, Andrzej Hajda <a.hajda@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jeongtae Park <jtp.park@samsung.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomasz Figa <tfiga@chromium.org>
Subject: [RFC PATCH 0/2] Document the V4L2 (stateful) Codec API
Date: Tue,  5 Jun 2018 19:33:26 +0900
Message-Id: <20180605103328.176255-1-tfiga@chromium.org>
X-Mailer: git-send-email 2.17.1.1185.g55be947832-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series attempts to add the documentation of what was discussed
during Media Workshops at LinuxCon Europe 2012 in Barcelona and then
later Embedded Linux Conference Europe 2014 in Düsseldorf and then
eventually written down by Pawel Osciak and tweaked a bit by Chrome OS
video team (but mostly in a cosmetic way or making the document more
precise), during the several years of Chrome OS using the APIs in
production.

Note that most, if not all, of the API is already implemented in
existing mainline drivers, such as s5p-mfc or mtk-vcodec. Intention of
this series is just to formalize what we already have.

It is an initial conversion from Google Docs to RST, so formatting is
likely to need some further polishing. It is also the first time for me
to create such long RST documention. I could not find any other instance
of similar userspace sequence specifications among our Media documents,
so I mostly followed what was there in the source. Feel free to suggest
a better format.

Much of credits should go to Pawel Osciak, for writing most of the
original text.

Tomasz Figa (2):
  media: docs-rst: Add decoder UAPI specification to Codec Interfaces
  media: docs-rst: Add encoder UAPI specification to Codec Interfaces

 Documentation/media/uapi/v4l/dev-codec.rst | 1084 ++++++++++++++++++++
 Documentation/media/uapi/v4l/v4l2.rst      |   14 +-
 2 files changed, 1097 insertions(+), 1 deletion(-)

-- 
2.17.1.1185.g55be947832-goog
