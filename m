Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeC1D0C (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 23:26:02 -0400
Received: from mail-bl2nam02on0041.outbound.protection.outlook.com ([104.47.38.41]:54790
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751179AbeC1DZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 23:25:59 -0400
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <Linux-imx@nxp.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V2 1/4] dt-bindings: timer: tpm: fix typo of clock name
Date: Wed, 28 Mar 2018 11:22:35 +0800
Message-ID: <1522207358-8388-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131666811573729419;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(7966004)(39860400002)(39380400002)(376002)(396003)(346002)(2980300002)(1109001)(1110001)(339900001)(189003)(199004)(26826003)(5660300001)(26005)(68736007)(47776003)(356003)(77096007)(336012)(53936002)(486005)(97736004)(486005)(105606002)(126002)(110136005)(106466001)(72206003)(36756003)(59450400001)(50226002)(81156014)(81166006)(51416003)(16586007)(316002)(50466002)(54906003)(48376002)(8936002)(450100002)(6666003)(86362001)(4326008)(476003)(2616005)(104016004)(508600001)(305945005)(85426001)(8676002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB3111;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD003;1:IrKBiKWZqju3RAqJLU7f1nDK0o5A3NCbk5IbR1Y7hCdR4jCKk9YGM2QfB/HJcLkUErwKAi+Cw1dXNdXfGsABuK4B5BN43J9x1GYZpyawr2D2fgGSreOj5gp/MaXAOuX5
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61e6db47-0b71-4625-0c22-08d5945b9ef1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:CY4PR03MB3111;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3111;3:OtFWeiLwYiUzBoSPtasIoIpiPwLL56cmRNKa64E2bsAWzCkKDiUXml8NRXHi3fTfHsGrVQPJuzEpnOXsZHc380tyEZjRCWAlZACcEfILarWHvDDNTUYXzjD2UdGdvpd/a9/RcL3EUIqmJCCPokTafeNskmomvZpZ4PIkjtcyMgyLCAe40wyR6xuHYN4ymvJr+uF8YzpCLGz6WnvQds5nfU8OihpmnHo9ihTf6c6NPaBnVOSbPazrzwOJx9A4AXEjqXVDDVamnomom6OJXjsd9zzw3UtXDtTPUDIzJtu4N7Q2QVd4dUaqrSn2bL8ONwYNhWYz4NKKKI40L378EvBKKnwd0hOU4afYAz+hRrxGYfM=;25:gnH5GWKei7tr5SXGTL9KzHdbp62ykbfQ8lZja03bz+Y6dD80EeBQG0LIVh9dnXT3bIp6xVHvV701z4zxkPujFCnmPpYVzHx/YFlFTmD7lDTjWh454Nvv4Wy0XPA9HE/yXtNRv0pO0AzrW6f2zEu++1lCb4BlKcbH03bHo5KIM3buzIqsXCMxTSVDRTH7l4r76mM9iHgi1Qlz/oMLtmsuObOkCFhRTs3B8hT4wKk7XyjSqxvQVCWGntYmiNdR7EtFUmD1KzR6zHgiD0cOmK8bHZWbLpusvC4ZTHHTwhQGUbIoKyerMj2U+zUSyVdtE8W1yaY6eCBYoZZUsP516bKZ3Q==
X-MS-TrafficTypeDiagnostic: CY4PR03MB3111:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3111;31:LShJpLUsZLHRSnwP4t/w6XHiie8DH81gnok/uxNFDSkMUUOxxDdC0KA6ui/rKAvpfj240t4fbQcul+iGp1Azue+M1hjnU6Ei33QTDT7JRYqzxQ8HqE0ihbs//AnO0u385LUFdtImo3ANQcWOxLD39kZkD/PXY2CjbRKDobVgjnLeWQQ7aH5KwZLvEOMA/y+0z+Ui9qXhg3plbAk//s++rGsEEizjAwkLODFev8h8Bo4=;4:lJajpUHPRYyyY+zzy6xZuyIkBTcZtwrg29fB6JOC/hB46ak81CBOxS2FrKZIn4ybLKkVS3dbCtvz1x9aLCoezxtIOpNwI2YVldnAu6iMtq9KOKAG/ErimE3JtGMlFk1kPkquu7iDr7HhCZ8ZhGxs2hoKo6EV3E4+piASKhasr5wPjEuIC8gQXy9WpKFHgP1Slrpug+kGgFDGjLOE2rsZnQq4/qTURnolFLzu8cl1C+mSgZBz/TNt++hBGElhO5peQVzLQ7NTRkRqaWXcL6EqPLVcTJTRpxFnms0oMmavG+GbqXZw2MZsLbCzr6Sisx/D
X-Microsoft-Antispam-PRVS: <CY4PR03MB3111EC3D84F2CE65D7E36B10F5A30@CY4PR03MB3111.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6096035)(20161123559100)(20161123556025)(20161123561025)(201703131430075)(201703131441075)(201703131448075)(201703131433075)(20161123565025)(20161123563025)(201708071742011);SRVR:CY4PR03MB3111;BCL:0;PCL:0;RULEID:(400006);SRVR:CY4PR03MB3111;
X-Forefront-PRVS: 06259BA5A2
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB3111;23:bd0vfnU4YMnN2JOvErBUq8FUEuKrnRbl27D7eu4xG?=
 =?us-ascii?Q?Sxep4iM6RbbDBlS87JRE/OwLHeezvgPEuUilTPG2n9WAzDO3Oz/Sl1HMs6iO?=
 =?us-ascii?Q?M9dPwBZzCCTPpsXRYo9ajKvYRG+5hrjEpICFGJhz3qvQoid5ErhHpZz2eIz1?=
 =?us-ascii?Q?XR+fGvmfD44+x0CYz0nCkKVBbH95Z0kOFEJL+WsW0/nkfr8nOJlHoP1zlueb?=
 =?us-ascii?Q?ts/clYrRzoFLYz+Z4jHXbMrJnLsy1sb59nYriDUS2dFTeEp8uREeVsn2zHuS?=
 =?us-ascii?Q?fQOE5/Y+X3W+jpFPN2KEvf3hO25Eip/SNG+5miTeNnvf8bfqM7cFLPHDNmen?=
 =?us-ascii?Q?oniIEbn8bpJbHxT0T+T3Mih/SkG6aW+YPB832W+tmNhRDHQa2ShHZadza23a?=
 =?us-ascii?Q?QxI2teUQmseqdj0A9g1d+hj8l6CnVBE+EK6TqZckn62NpH8vUzskO+J3la7U?=
 =?us-ascii?Q?NspCsnz22qMYg5z8vOU4nydJzjx2o3V0TcF/wZrwnryo78vDR/njKAFPopF2?=
 =?us-ascii?Q?GdEUTKJ0hA3i+txrZYJZc5TkqNBUIdNojDr4WAeqGl0hqeGLRap3Y0lhulM1?=
 =?us-ascii?Q?sIQAhKjnq9KUFXPTcuymkK+WkRErothchTsf6tToV/ooUjP8llgeA0WN9//f?=
 =?us-ascii?Q?FUzwWISyizJma0Rh8siSfSR4W0s7Mc4UQEpngm6GeTM+6D8agiBw69nazLjP?=
 =?us-ascii?Q?XpIaxa/SQUfnoRnq0/NDHyeauSD50K7HTVj2oNxoJzg4wqPgVcbd9WXFI75t?=
 =?us-ascii?Q?IXQu0pmeb/QI/v9guEOVkpxfmEYVu4WVFMw1Ny04DVX1p29tk+oHneV4WwMV?=
 =?us-ascii?Q?n7umJjgtSxqGlmzvS1Q2shH3ATB4f2XHriHaSwrICVAgufpyBrdWVGqWsPja?=
 =?us-ascii?Q?s4uOiwy57Z1aupeVeITkjq4bqkogYZOgN2W2uI7znMV9MNfJs6OwcRJkmwKO?=
 =?us-ascii?Q?4yZXJ9XNKHBtigyXrhfNvyxw1fxDwFXZ4SsX/a2jhx3RNBBIxlmxCBQOV6qE?=
 =?us-ascii?Q?Jtd681Z1cJw2zcEQnS9xSTZCroTC6LY+20+X/FkKQwXIGczFzuKdUh2m74i7?=
 =?us-ascii?Q?YZjPl4H2sliyDUPX3PF1zusvKJZ+6jvUoZmkOaDmAgVYYRWtG3OL1HNozLaj?=
 =?us-ascii?Q?AcpIHLyxH+Umq0qIs7YzRdJrgIDLly2+1GYuEkojXEdM0luocsqslebBnR7T?=
 =?us-ascii?Q?SsYrPgyRkTGDG7aijhfWht+Ho5x4PjY2ns6?=
X-Microsoft-Antispam-Message-Info: Q78y3593kJRtxGDzpe4GQETO2S4hUolsyeQ2HHoa3z5h+Mt8Rf74ZjCDY6eOPdVH/gWPgkxQyha2Ns/bZya235eKL14lSTsmWZKP4rT5u3Z3OwhAPxQ4iF4LmSBBqaWzX9TAWDHMNEzQWCEkoFVz6n4cBjik+9V9xxqA2FyJG8FMp5Fzf8z4lr1os1xhSYVB
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3111;6:zTc9Fux6m5NHBysLd6Dnpnr9Nu0k3VNuH6q7BLd9PR7Bwkw9d0rJhZtOovi8KxigGnFbwDdA2UfKpCoCUDIWTZWG4YZAUlbSuC4CLEYl7grY62ysxAwCoQ2gvCBjZOY+QMAug+tvq0s6WK1E6p4IKKfBIvPlu6y+dLRDnOKinSp9NYMmqQKDiM33mz5tRQoK71bOyWg4EiIzNkZZ+uHgfhu71ohji99x2qFNNFvoGV+QXm5YzlPGU7VCfwFqfaL/VLSi8kZP+5PL5v74HesUKM4MDccRkMHviniYH0PsZCkrOftQv5XN2dJbQNZzJ96r6CzXvgjbu4ORh+dgDlZAFsYKl+p8gngwb3s1QVmflDo7t9oo9EoVshCNqzM7w2jn886aW8Dh2E2uWIQdvDGC1njSbOqBuYloo/v0mjwNXkHgI4KtkuKvWdJl/wl9BK3hNQ9EOa369ePLrCLmTcylKQ==;5:peCAPwzY5k4oiCQHSMSpkUmfE82OaYRT29KgVXmaNxKWZPd/Fu6yI5Sgi/8CPIOg2RZMl8xShjKbtjfkVexnzkjIiTCGV91cQTr8AVEWkowYmYr2tkYdJbFBOH4HMOm8TS4uplna3xXih/Dr9DuyHPNtcAlzQ7qz6JUzDGRyFGY=;24:YgpsMKEy8gh0vnOVoHkpRq6IqpZ8+3E7bYg2rpuTf8qf6pDZRd9hPyJHYW9WGtQkQjxOAqDaBjowgbw+K1z/7b4tLHXVjos8eb+nmVWLMXA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3111;7:FjldIeTX6gEYe6rcX0T3UrF+BburVPcOyJQ1nzma5FIGSlmeVMg+iqyIptMduAiT3nKS16Ay0tYE+aALN1wScQO2ZhR24XXKFY9tkMmU/eiz9qAYrQgLJZAwA5K9q0BhxHPujzl3UIk22DCzA4OeXqx1W7ueGp7LzIQUgoDYh7IZ6mA787J623BtH8lxPiEcpcS5rVnYguM4RdkKq++M4MZa6tIdVbsu5CcZBC6grDnpch4gi43jQgjlxkhqxSx2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2018 03:25:57.0297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e6db47-0b71-4625-0c22-08d5945b9ef1
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3111
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock name should be ipg instead of igp.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt b/Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt
index b4aa7dd..f82087b 100644
--- a/Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt
+++ b/Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt
@@ -15,7 +15,7 @@ Required properties:
 - interrupts :	Should be the clock event device interrupt.
 - clocks :	The clocks provided by the SoC to drive the timer, must contain
 		an entry for each entry in clock-names.
-- clock-names : Must include the following entries: "igp" and "per".
+- clock-names : Must include the following entries: "ipg" and "per".
 
 Example:
 tpm5: tpm@40260000 {
-- 
2.7.4
