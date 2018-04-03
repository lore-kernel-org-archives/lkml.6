Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755410AbeDCJVJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 05:21:09 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33253 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755277AbeDCJUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 05:20:49 -0400
X-Google-Smtp-Source: AIpwx4+/v787PtkYA+dQ56W/wcxMYEpGklv1VxsX1o4BsPlfO99ri0VY1JbM+FrWBJUX2HnBbmuqIg==
From: SeongJae Park <sj38.park@gmail.com>
To: paulmck@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, SeongJae Park <sj38.park@gmail.com>
Subject: [PATCH 3/5] kokr/Documentation/memory-barriers.txt: Cross-reference "tools/memory-model/"
Date: Tue,  3 Apr 2018 18:20:25 +0900
Message-Id: <20180403092027.13471-4-sj38.park@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180403092027.13471-1-sj38.park@gmail.com>
References: <20180403092027.13471-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit applies an upstream change, commit 621df431b0ac
("Documentation/memory-barriers.txt: Cross-reference
"tools/memory-model/"") to the Korean version document.

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
---
 Documentation/translations/ko_KR/memory-barriers.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index 44e47c2d33cf..2c0ab128cd04 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -36,6 +36,9 @@ Documentation/memory-barriers.txt
 부분도 있고, 의도하진 않았지만 사람에 의해 쓰였다보니 불완전한 부분도 있습니다.
 이 문서는 리눅스에서 제공하는 다양한 메모리 배리어들을 사용하기 위한
 안내서입니다만, 뭔가 이상하다 싶으면 (그런게 많을 겁니다) 질문을 부탁드립니다.
+일부 이상한 점들은 공식적인 메모리 일관성 모델과 tools/memory-model/ 에 있는
+관련 문서를 참고해서 해결될 수 있을 겁니다.  그러나, 이 메모리 모델조차도 그
+관리자들의 의견의 집합으로 봐야지, 절대 옳은 예언자로 신봉해선 안될 겁니다.
 
 다시 말하지만, 이 문서는 리눅스가 하드웨어에 기대하는 사항에 대한 명세서가
 아닙니다.
-- 
2.13.0
