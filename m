Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752164AbeFETn4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:43:56 -0400
Received: from mout.gmx.net ([212.227.15.19]:55137 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751849AbeFETny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:43:54 -0400
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linux-doc@vger.kernel.org
Cc: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jonathan Corbet <corbet@lwn.net>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: atomic_ops: atomic_set is a write (not read) operation
Date: Tue,  5 Jun 2018 21:43:23 +0200
Message-Id: <20180605194326.23596-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:eGi03/YAeBxduuaAlCaATKc0Ti5lOLopeOrEWlhlofNlrxAERnX
 p4x2iI6cLGpwRF9HATnaKYNf0npo3zupg+Nwd3CW+OX5GeaffITEZpOXhwZ5RycX3UMKHaY
 +uZWvrj7/Zcs9mrdqjQxrbLzBd8z/Rt0r4OWyfxFJBWs1Y7YpN1yiSelZDFss6/ILl0Vrtj
 xUs5w8W74PeFU973ynOfw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Pke5WB5g3aA=:CxEVLudFQD8snKyE+LPlFT
 9VSrJG3+61FXcmS0x2V3Vemz35drR63AUCQz6knPAAzuzbZQnHHkuh9/dHjSe4ndpTmg79Z2Q
 fPcwS6AFtVGNRbdob7ibkR6pWJi4udPifim97WWR1MwB8dpWVXYXNRrPTrNXolChBAIgj41P0
 ovR6W4nfo+eMCoB3xwYkP58xidB9id48wMZBBDHi7yNej7FnI/c8Tipzee0m8tQGufBv19HFW
 zWI2I6mlI7XWWIp5sDXF43FR+T6j1MvGq/bodtDJbBcjzEa06KkjvZdPB7DyzXm/as43H+dFy
 lUUYUR6DyJJ13bQsdEkPfO/2jGShR1EInLZrQA2ORGtqs18MdybOcWEnfcDPgAWKEb6GpES4P
 gEMOSHs50ncV7cY/g/74ns8G3TxpeS95PgA6j+tyQtMW/jy2uYkCC3oJMaPzXcAbJbsDJiXK0
 npd46rqKneGdf2PeXW27SUg/zcq/FcUNSgmdMion524uUAJTFHdmc30zAZ3TxD+OVndR4AyjK
 5NehfjXK2Omf7HnqYu8Oxqy0f3E0pKo2kPRqoVP6kASNJQKpoYpK1eI6w64z3fB8IOruAB48F
 qOXAvGJhD+HMmhAAY9u74QEun0UiOfpLOtuJXdKg2UKRpBp8G0UFiqju2MfKMT2lXrepTh4MV
 43IGpxsWYQkQVGhzTUnPp5OrXiclFGzSo3BX20KMThFkNbp/qD8AjvTKI0fzeb6Rqy9o4qoH/
 iMWXeKJJudoXhORvyVTsP16DcVJos0BLkkkysTKEqU58NiqXOh2B6nr7oIeXsXbHxFP7ARfzu
 LoBlK6I
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe it as such.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 Documentation/core-api/atomic_ops.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/core-api/atomic_ops.rst b/Documentation/core-api/atomic_ops.rst
index 2e7165f86f55..724583453e1f 100644
--- a/Documentation/core-api/atomic_ops.rst
+++ b/Documentation/core-api/atomic_ops.rst
@@ -29,7 +29,7 @@ updated by one CPU, local_t is probably more appropriate. Please see
 local_t.
 
 The first operations to implement for atomic_t's are the initializers and
-plain reads. ::
+plain writes. ::
 
 	#define ATOMIC_INIT(i)		{ (i) }
 	#define atomic_set(v, i)	((v)->counter = (i))
-- 
2.17.1
