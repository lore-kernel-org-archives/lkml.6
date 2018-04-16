Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753364AbeDPQOR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:14:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36808 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753069AbeDPQLs (ORCPT
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
Subject: [PATCH tools/memory-model 10/17] kokr/memory-barriers: Fix description of data dependency barriers
Date: Mon, 16 Apr 2018 09:12:38 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180416161209.GA6895@linux.vnet.ibm.com>
References: <20180416161209.GA6895@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18041616-0024-0000-0000-00000347CE61
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008863; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01018801; UDB=6.00519703; IPR=6.00798042;
 MB=3.00020599; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-16 16:11:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041616-0025-0000-0000-000047AEEA41
Message-Id: <1523895165-17576-10-git-send-email-paulmck@linux.vnet.ibm.com>
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

This commit applies an upstream change, commit 51de78892b12
("memory-barriers: Fix description of data dependency barriers") to the
Korean version document.

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
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
2.5.2
