Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx49FvN6EpG+ZzGbpbV6M+gBnTDuf+FB2XbmGIuWHuhaS3QmmHiI5CRzlzWcqNTvirEv+/jKN
ARC-Seal: i=1; a=rsa-sha256; t=1522476573; cv=none;
        d=google.com; s=arc-20160816;
        b=hjOLVyhe+7AwvOAm4O26GQOeVMNLTSKuaDxOQecwYmgjRd2mBafHD3yGymg5oxKeDo
         k7nW0tDodnT5w3unxZ39n0ZrC/jYucq7dGjLUQBZ3rJiLaeazT/Ro1VK/WCu3TsdX867
         wqKf4HxkXAkQg2COspb0JQge5D/dIVoazs0X4pREU5/qtTGUdn4fPGfhLJPIMJaLpnX1
         g3ea80DIWoHSnDcT5yGlU6BzBKFGD7WYDiT/h4VuDktJcCzSyswV9A7/jWizSz0oK9Gb
         j9HUmyL3sfI5RvYPVRNfWffLg31H7GcIEP7oKwVid5ZMOWGOyDD2SPwCD5cH1SekEnww
         qzbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=xg2ijFEW6gRDR6eWPSZtl0CIXnRHgmUduz1C13EBprw=;
        b=wp+NN0B1RIP4pOBk0WcodQbSRAd9dMRdF0+yUA7xKjV0bV26NnztvBeZWIALqgoarA
         HTT7qyAs4EiLljgFyicVGdzkTe/PDJBNyZmh+QkXytLba6ALbR5oN9LYznGbX2DthIan
         OFXiOnuCCEP4HTioaOAHiRDlJ1e73QshtfUTStXQDKr7brqeGHOAS7YWIZeg9VZ1txaQ
         ISVa6OYup3ZvoAFv1BuEI1ScpS9RW8A8avSVJ1yGOeB6WBq5pULKkpJqpD+eRy+l96vR
         3rknjDHgjmffKzXzpdzM4QWaqyR+i9RAcwT4WmLob8IXpqldm4CZ2pAgElhc3U+VJlXl
         VoMg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH v2 12/75] staging: ks7010: Remove unused 'struct hostif_mib_set_confirm_t'.
Date: Fri, 30 Mar 2018 23:07:52 -0700
Message-Id: <20180331060855.9452-12-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:EQA769O5ig1lqNKy9XHxJTse6ufSbssYBHhoFgUQL2zsomBYhhY
 ChhsL7nP/0tTTpVppXbMiUXmNpkNI+cXymQqWd/jJOhKnqt68xkLqHazAO7S38+KKefoLsP
 hLjCqvwbJn/CxxsQfpSEiPzuzqewndrlK8x3YBRHd7W3ir4RqYRHLKsVpxB0mlAevpYyHci
 6jm1vazJ5ucg03N5NX3kA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nn5iIjASXkE=:erCRpBoEiIiHlz4y91epww
 QJMtbPtL8JtkZGiffdPUnyBrzt5XbFURobmVQtyZHEJqY04ZeqXvEldBIh+cx+hc2GSIjeqfx
 5ZZUjhCJIQFFC2HPmJWwh1MuAR3sxIfMtE87N36SuXXwpioQ3S1EtUPOy9YCA4oj32jPMvdrM
 A0wWX/gKXxNkv91464+pJM/fXrOYdOHtwnCXa+PiaD9bY2jNz/f65FeHRflacE0lAnJgshtFT
 quIet6buzqwCICbnyNFbthPBjxKdNtW+ixAZIVFRsQkW3FR/x9rZwpCCTNB6AnzbFXu9BQ8ln
 BmiuLGvhcuEXP51d+H7ASXZqLiVQrG85Ia5BHOehqv+oOBkDOuN/FjLQOqrsPiFSvFHPl9vtU
 9VVoG2qI18j8tZ69/FPvGLcF4ezanmSg2JSUe3J2MeOoPLYYITDZnmEZr0FK65+Ab876KZ+ZB
 4AMKstAvZj6p6uTnof0QAj0GqMh2pYntjTV95xQKJATqZ6DKcUgwR4hJ9HDeQS1FHheT/E6vo
 cbEyIh9HDeCseXxhhK3XXijiJ4k9qBCuSVEx5H4a3FWLfmgqN5ypfp/F1MCUQrQzrLQFLUhye
 9j3gayKD2MbXOMhsyLDJLn6G/XOjolQWnw9buGG05Wjn9LdNPnq26FOYQRl5CDpDVs6z3s+ee
 VubmlR4H0aUQxdXinmygeOm1BnnRfIMPj+i0wL6SqN+JqXzQ+UEOIj3zigEL47H+s0P+j+r3M
 p7fTrQHMVDWbEIKcEM8S+wBov5e1+fpf0X9GDQ==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432395435669340?=
X-GMAIL-MSGID: =?utf-8?q?1596432395435669340?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

'struct hostif_mib_set_confirm_t' is not used in this driver. Remove
'struct hostif_mib_set_confirm_t'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 157f1c2394c3..5ae6f78eebd6 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -162,12 +162,6 @@ struct hostif_mib_set_request {
 	struct hostif_mib_value mib_value;
 } __packed;
 
-struct hostif_mib_set_confirm_t {
-	struct hostif_hdr header;
-	__le32 mib_status;
-	__le32 mib_attribute;
-} __packed;
-
 struct hostif_power_mgmt_request_t {
 	struct hostif_hdr header;
 	__le32 mode;
-- 
2.16.3
