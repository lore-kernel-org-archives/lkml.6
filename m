Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753278AbeB0Nqe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 08:46:34 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:39345 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752621AbeB0Nqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 08:46:32 -0500
X-Google-Smtp-Source: AG47ELul295H5Uv3z4r6ZyQ3Um1v7sUoucN8QXyDxWHbpyNTlAitHZws4q6vUVogpuwXutBbj2QEtQ==
Date: Tue, 27 Feb 2018 10:46:27 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: daniel.baluta@nxp.com, kernel-janitors@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] iio:dummy: Rework Kconfig
Message-ID: <cover.1519738995.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds extra documentation inside iio/dummy/Kconfig, and
applies the coding-style to it.

Changes v2:
- Separates single patch in a short series.

Rodrigo Siqueira (2):
  iio: dummy: Add correct tabs and spaces to Kconfig
  iio:dummy: Add extra paragraphs on Kconfig

 drivers/iio/dummy/Kconfig | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

-- 
2.16.2
