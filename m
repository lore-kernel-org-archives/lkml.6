Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755388AbeDCJUy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 05:20:54 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34737 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755355AbeDCJUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 05:20:50 -0400
X-Google-Smtp-Source: AIpwx4+6svriTw8b1tA5vBlRCLrMrHKwPjV4Bd4ljp+9NFqD9UanAnSP7rk/PNm4Pt8/yjVLqhc6RA==
From: SeongJae Park <sj38.park@gmail.com>
To: paulmck@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, SeongJae Park <sj38.park@gmail.com>
Subject: [PATCH 4/5] kokr/memory-barriers: Fix description of data dependency barriers
Date: Tue,  3 Apr 2018 18:20:26 +0900
Message-Id: <20180403092027.13471-5-sj38.park@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180403092027.13471-1-sj38.park@gmail.com>
References: <20180403092027.13471-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit applies an upstream change, commit 51de78892b12
("memory-barriers: Fix description of data dependency barriers") to the
Korean version document.

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
---
 Documentation/translations/ko_KR/memory-barriers.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index 2c0ab128cd04..99ef4ca1c1bf 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -427,8 +427,8 @@ CPU 에게 기대할 수 있는 최소한의 보장사항 몇가지가 있습니
      데이터 의존성 배리어는 읽기 배리어의 보다 완화된 형태입니다.  두개의 로드
      오퍼레이션이 있고 두번째 것이 첫번째 것의 결과에 의존하고 있을 때(예:
      두번째 로드가 참조할 주소를 첫번째 로드가 읽는 경우), 두번째 로드가 읽어올
-     데이터는 첫번째 로드에 의해 그 주소가 얻어지기 전에 업데이트 되어 있음을
-     보장하기 위해서 데이터 의존성 배리어가 필요할 수 있습니다.
+     데이터는 첫번째 로드에 의해 그 주소가 얻어진 뒤에 업데이트 됨을 보장하기
+     위해서 데이터 의존성 배리어가 필요할 수 있습니다.
 
      데이터 의존성 배리어는 상호 의존적인 로드 오퍼레이션들 사이의 부분적 순서
      세우기입니다; 스토어 오퍼레이션들이나 독립적인 로드들, 또는 중복되는
-- 
2.13.0
