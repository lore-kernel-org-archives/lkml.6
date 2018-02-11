Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932228AbeBKVum (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 16:50:42 -0500
Received: from mout.gmx.net ([212.227.17.21]:34429 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753711AbeBKVuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 16:50:39 -0500
From: "Enrico Weigelt, metux IT consult" <metux@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: p9caps: add Plan9 capability devices
Date: Sun, 11 Feb 2018 21:50:27 +0000
Message-Id: <20180211215028.16210-1-metux@gmx.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <40d4c871-a16a-7b8f-2d4a-422a5a490693@infradead.org>
References: <40d4c871-a16a-7b8f-2d4a-422a5a490693@infradead.org>
X-Provags-ID: V03:K0:WOTabf09NsAd/QpmDFKp2RnnGDq2S8rEMg4MTh3nDnLx2hKDp2q
 fbryO3atcXKTHPGe9DSB31MdBUpoajIx4mQp+6Hsea4gzmQONJ8qRIExfx8V2mA7QuTE/By
 ppSMrG2CjqrnPIc20Aep+wLNVUlhBZBAcyQOamKq5f6khEookZr6yeHFzbj5ikVWpS4g2//
 ilSiOcMfJrk8wm6EU0tHw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:17ulX5v6Y+w=:WT7CuHz8OhKtpGB4Hw4kB1
 LIXaw3HCayipVIM6UwHSZx5OyNzjvXIfUiWauZhfXFgbechenA1FadkLmcYHPBRgK1iH3+4l2
 TZaY3I4n5RA79s2gKFExuVN56rq0+okduCyJ3WQAmMc2qLGYUDqOK1QGXbzpjgXUZ2KFlq8Dx
 QGTk/3GShcA3QH9S6l3D02BD1BT2ZAyG7K6F+qUinhcwW3AexfNJgjqOBqj1B+eP5RRo8FHvI
 MO4nhoG/MyxzKMA8oBiA46VTZWYRPPlh/58oEvHBNe6KeoFvleXxLNjoPd5Xgs3vMCpLRLj/m
 sbt/rXOq7G6dIR63eP0lNvFC/WaC3Rz+Dqa6jra/SlI5GBRrYOzwWosyT5tGFoTUXAQcf7yTi
 SxJtqH8V6XCGk7LzN65if3Ea6sxoC0PLaDHEIdOQdzc9G/g1JoPxIlGEXwPILO6nwiEOIi3A0
 BWfAqxJOC3wTzQTBn931I6p2fk9q47JCerjKW4JBFue5cZOL2M0YMO4cfxWbZTuU/mgG6JXn1
 7w0upFVEqQubQ1+USOcXiRFeQG8hmwPUQh0FvSdjy20NMMiv/GgN4dYv/hWZpdQ7ygtlQNQFm
 FlcssD9A0yYEY1PzocAPQWBSZt45rZGTLL55pAIGExNJzaSRYAvqadiKs+XE6uhhoTNwXMLrt
 OY6yVHNK5evmxGZstZv2qLIVbmBw0aS4GO0H4DGuW642c5Mmn4X0SlhnKqRJb8mnvfKLwFl+p
 SX/NYqFjUlISXAOenClaXDkgU6fjqqAAAwSjcZp6ZoOwUMu2ipZWsp3xbjBgWrOTGk+dcsMrk
 PmPPodNIa9fMaS3vnAoO4MUy2SP0w==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


v2 of the p9caps patch
