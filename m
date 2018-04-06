Return-Path: <greybus-dev-bounces@lists.linaro.org>
X-Google-Smtp-Source: AIpwx49q3+BWLWf4RTU3RYEEanzRAyv8c/uz51FHooytVHZZ1bRnUbseJhDrkoYojp69QhJ5681D
ARC-Seal: i=1; a=rsa-sha256; t=1523010337; cv=none;
        d=google.com; s=arc-20160816;
        b=J6IYqQu05kRQw7lJ50XBON8Kmt0sK/amP0J8eVqqoz68G5mhK19h7V6UG16/uz3vPi
         f+WGf+O8q0UX/nL/JwRfnsxRs4HymwXZCQ9F3A5jSWq1SsdoofuxomPezO6kkpQQw/rx
         G1BgGdilVSsSBb520StWAXs5CpjgFjHxPVAtBXlRz5hd8yZmzvO79c+NPbOpch3sdCA4
         TZkK32moQnotI+8wyKm+ojz7nbNOYAC4khYddopP2SooLcQt3PRG5hxAXHoZCaMEBVpZ
         1n46nBDZH5RPhUD8SEJo557UkYxaEFEzFKJRUg2zG4iBen+4L5carKekeBcKRYLyAk2X
         6LyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:errors-to:content-transfer-encoding:list-subscribe:list-help
         :list-post:list-archive:list-unsubscribe:list-id:precedence:subject
         :user-agent:content-disposition:mime-version:message-id:to:from:date
         :delivered-to:arc-authentication-results;
        bh=wgjoRsIsQjmX0Jmxx0gubi4TCBH+YmMBMIAC4wFNExM=;
        b=BXNEXffKQ5DMys2B5p2qCS/DuoD4xN8ssBV9eD5cGkOAUzoZJn25xY8WRO/3EBIYI6
         3GgS+gKAzqb1k8WE2UeU65Fvzjo57/peqoVC1wSnWplSijvAMzh8EO1mf+F0L0b8vf2i
         OU5IrfFgzJ4KsdP7fuNw1WZhZ26KY0fyCsCZZR3e29W8dv1nub/srMn57KZ9kwd0uit6
         cEYEnm0JlIDtYJYSptBnbK8AzjHrvBUFFgIbDeES8xcbc1xIAkdM37iq0IU+tvQZtRFG
         LKdVg1vJ8zEb3znC4k9VZq4znOpl0FmBQ5szzFAnkG47NTkpbUZVzQuqNGJ6VBl+7WZw
         xUiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of greybus-dev-bounces@lists.linaro.org designates 54.197.127.237 as permitted sender) smtp.mailfrom=greybus-dev-bounces@lists.linaro.org;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of greybus-dev-bounces@lists.linaro.org designates 54.197.127.237 as permitted sender) smtp.mailfrom=greybus-dev-bounces@lists.linaro.org;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Date: Fri, 6 Apr 2018 15:39:53 +0530
From: Gaurav Dhingra <gauravdhingra.gxyd@gmail.com>
To: vaibhav.sr@gmail.com, mgreer@animalcreek.com, johan@kernel.org,
 elder@kernel.org, greybus-dev@lists.linaro.org,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Message-ID: <20180406100953.GA12400@stallman>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Mailman-Approved-At: Fri, 06 Apr 2018 10:25:32 +0000
Subject: [greybus-dev] [PATCH v2] staging: greybus: Fix warning to limit
	chars per line
X-BeenThere: greybus-dev@lists.linaro.org
X-Mailman-Version: 2.1.16
List-Unsubscribe: <https://lists.linaro.org/mailman/options/greybus-dev>,
 <mailto:greybus-dev-request@lists.linaro.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/greybus-dev/>
List-Post: <mailto:greybus-dev@lists.linaro.org>
List-Help: <mailto:greybus-dev-request@lists.linaro.org?subject=help>
List-Subscribe: <https://lists.linaro.org/mailman/listinfo/greybus-dev>,
 <mailto:greybus-dev-request@lists.linaro.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: greybus-dev-bounces@lists.linaro.org
Sender: "greybus-dev" <greybus-dev-bounces@lists.linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596750959468280779?=
X-GMAIL-MSGID: =?utf-8?q?1596992087904694659?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

U2lnbmVkLW9mZi1ieTogR2F1cmF2IERoaW5ncmEgPGdhdXJhdmRoaW5ncmEuZ3h5ZEBnbWFpbC5j
b20+Ci0tLQpDaGFuZ2VzIGluIHYyOgogICAgLSB1c2UgY29ycmVjdCBmb3JtYXQgZm9yIG11bHRp
bGluZSBjb21tZW50Ci0tLQogZHJpdmVycy9zdGFnaW5nL2dyZXlidXMvYXVkaW9fY29kZWMuaCB8
IDUgKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvZ3JleWJ1cy9hdWRpb19jb2RlYy5oIGIvZHJp
dmVycy9zdGFnaW5nL2dyZXlidXMvYXVkaW9fY29kZWMuaAppbmRleCBhMWQ1NDQwLi40ZWZkOGIz
IDEwMDY0NAotLS0gYS9kcml2ZXJzL3N0YWdpbmcvZ3JleWJ1cy9hdWRpb19jb2RlYy5oCisrKyBi
L2RyaXZlcnMvc3RhZ2luZy9ncmV5YnVzL2F1ZGlvX2NvZGVjLmgKQEAgLTIzLDcgKzIzLDEwIEBA
IGVudW0gewogCU5VTV9DT0RFQ19EQUlTLAogfTsKIAotLyogZGV2aWNlX3R5cGUgc2hvdWxkIGJl
IHNhbWUgYXMgZGVmaW5lZCBpbiBhdWRpby5oIChBbmRyb2lkIG1lZGlhIGxheWVyKSAqLworLyoK
KyAqIGRldmljZV90eXBlIHNob3VsZCBiZSBzYW1lIGFzIGRlZmluZWQgaW4gYXVkaW8uaAorICog
KEFuZHJvaWQgbWVkaWEgbGF5ZXIpCisgKi8KIGVudW0gewogCUdCQVVESU9fREVWSUNFX05PTkUg
ICAgICAgICAgICAgICAgICAgICA9IDB4MCwKIAkvKiByZXNlcnZlZCBiaXRzICovCi0tIAoxLjku
MQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZ3JleWJ1
cy1kZXYgbWFpbGluZyBsaXN0CmdyZXlidXMtZGV2QGxpc3RzLmxpbmFyby5vcmcKaHR0cHM6Ly9s
aXN0cy5saW5hcm8ub3JnL21haWxtYW4vbGlzdGluZm8vZ3JleWJ1cy1kZXYK
