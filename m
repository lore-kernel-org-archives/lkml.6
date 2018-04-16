Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753347AbeDPQOP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:14:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36726 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753084AbeDPQLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:11:48 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        SeongJae Park <sj38.park@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tools/memory-model 09/17]  kokr/Documentation/memory-barriers.txt: Cross-reference "tools/memory-model/"
Date: Mon, 16 Apr 2018 09:12:37 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180416161209.GA6895@linux.vnet.ibm.com>
References: <20180416161209.GA6895@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18041616-0040-0000-0000-0000041BB4AC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008863; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01018801; UDB=6.00519703; IPR=6.00798043;
 MB=3.00020599; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-16 16:11:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041616-0041-0000-0000-00000821B83D
Message-Id: <1523895165-17576-9-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-16_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804160146
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sj38.park@gmail.com>

This commit applies an upstream change, commit 621df431b0ac
("Documentation/memory-barriers.txt: Cross-reference
"tools/memory-model/"") to the Korean version document.

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
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
2.5.2
